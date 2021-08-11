//@dart=2.9
import 'dart:async';
import 'package:app_prueba/authentication/domain/entities/user.dart';
import 'package:app_prueba/authentication/domain/repositories/authentication_repository.dart';
import 'package:app_prueba/authentication/domain/repositories/user_repository.dart';
import 'package:app_prueba/util.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    @required AuthenticationRepository authenticationRepository,
    @required UserRepository userRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      _authenticationRepository.logOut();
    } else if (event is AuthenticationFailed) {
      _authenticationRepository.failed();
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription?.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        var jwt = await checkToken();
        return jwt != null
            ? AuthenticationState.authenticated(User(jwt))
            : const AuthenticationState.unauthenticated();

      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated();
      case AuthenticationStatus.failed:
        return const AuthenticationState.failed();
      default:
        return const AuthenticationState.unknown();
    }
  }

  Future<User> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } on Exception {
      return null;
    }
  }

  Future<String> checkToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jwt = await prefs.getString("token");
      if (jwt != null) {
        return jwt;
      }
      Map<String, dynamic> decodedJwt = Utils.parseJwt(jwt);
      if (decodedJwt["exp"] < (DateTime.now().millisecondsSinceEpoch/1000).round()){
        return null;
      }
      
    } catch (e) {
      return null;
    }
  }
}
