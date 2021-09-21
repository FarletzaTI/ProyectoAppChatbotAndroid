//@dart=2.9
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'authentication/domain/repositories/authentication_repository.dart';
import 'authentication/domain/repositories/user_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}
