// @dart=2.9
import 'package:app_prueba/const/gradient.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Container(
              child: Image.asset("images/logotransparencia.png"),
              width: MediaQuery.of(context).size.width * 0.40,
            ),
            SizedBox(height: 50),
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
          ],
        ),
      ),
    );
  }
}

_buildFormChildren(BuildContext context) {
  return [
    CustomTextForm(
      function: (input) => {},
      changed: (value) => {},
      hintText: 'Usuario',
      prefixIcon: MdiIcons.accountOutline,
      keyboardType: TextInputType.text,
    ),
    CustomTextForm(
      function: (input) => {},
      changed: (value) => {},
      hintText: 'Contraseña',
      prefixIcon: MdiIcons.formTextboxPassword,
      keyboardType: TextInputType.text,
    ),
    _submitButtom
  ];
}
Widget _submitButtom() {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: primaryColor,
      highlightColor: primaryColor,
      splashColor: Colors.white.withAlpha(100),
      padding: EdgeInsets.only(top: 16, bottom: 16),
      onPressed: () {},
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              "ENVIAR",
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Positioned(
            right: 16,
            child: ClipOval(
              child: Container(
                color: Colors.blueGrey,
                child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Icon(
                      MdiIcons.arrowRight,
                      color: Colors.white,
                      size: 18,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
