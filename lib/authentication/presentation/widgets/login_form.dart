//@dart=2.9
import 'package:app_prueba/authentication/presentation/bloc/login/login_bloc.dart';
import 'package:app_prueba/const/gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              child: Image.asset("images/logooff.png"),
              width: MediaQuery.of(context).size.width * 0.80,
            ),
        
          Container(
            margin: EdgeInsets.only(left: 24, right: 24, top: 16),
            child: Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 8.0,
                        color: Colors.black12,
                        offset: Offset(0, 3)),
                  ]),
              child: Column(
                children: _buildFormChildren(context),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _LoginButton(),
          )
        ],
      ),
    );
  }

  List<Widget> _buildFormChildren(BuildContext context) {
    return [
      _UsernameInput(),
      Divider(
        color: Colors.indigo[100],
        height: 0.5,
      ),
      _PasswordInput(),
      
    ];
  }
}


class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
        prefixIcon: Icon(MdiIcons.accountOutline),
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
            color: Colors.black26),
        hintText: "Usuario",
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.all(16),
      ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
        prefixIcon: Icon(MdiIcons.lockOutline),
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
            color: Colors.black26),
        hintText: "Contraseña",
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.all(16),
      ),
        );
      },
    );
  }
}
class _LoginButton extends StatelessWidget {
  final ButtonStyle style = ElevatedButton.styleFrom(
    primary: primaryColor,
  );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                child: const Text('Ingresar'),
                style: style,
                onPressed: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}
