//@dart=2.9
import 'dart:async';
import 'package:app_prueba/authentication/domain/entities/user.dart';
import 'package:uuid/uuid.dart';

class UserRepository {
  User _user;

  Future<User> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(Uuid().v4()),
    );
  }
}
