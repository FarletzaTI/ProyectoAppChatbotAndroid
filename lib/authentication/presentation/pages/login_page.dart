//@dart=2.9
import 'package:app_prueba/authentication/domain/repositories/authentication_repository.dart';
import 'package:app_prueba/authentication/presentation/bloc/login/login_bloc.dart';
import 'package:app_prueba/authentication/presentation/widgets/login_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
          );
        },
        child: LoginForm(),
      ),
    );
  }
}
