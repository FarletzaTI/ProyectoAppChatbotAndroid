//@dart=2.9

import 'package:app_prueba/const/gradient.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class CustomAnimatedButtom extends StatelessWidget {
  final VoidCallback onPressed;
  final ButtonState stateTextWithIcon;
  const CustomAnimatedButtom({Key key, this.onPressed, this.stateTextWithIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24, right: 24, top: 16),
      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
      child: ProgressButton(
        stateWidgets: {
          ButtonState.idle: Text(
            "ENVIAR",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          ButtonState.loading: Text(
            "CARGANDO",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          ButtonState.fail: Text(
            "ERROR",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          ButtonState.success: Text(
            "ENVIADO!",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          )
        },
        stateColors: {
          ButtonState.idle: primaryColor,
          ButtonState.loading: primaryColor,
          ButtonState.fail: Colors.red.shade300,
          ButtonState.success: Colors.green.shade400,
        },
        onPressed: onPressed,
        state: stateTextWithIcon,
      ),
    );
    /* ProgressButton.icon(iconedButtons: {
      ButtonState.idle:
          IconedButton(text: "Send", icon: Icon(Icons.send,color: Colors.white), color: Colors.deepPurple.shade500, shape),
      ButtonState.loading:
          IconedButton(text: "Loading", color: Colors.deepPurple.shade700),
      ButtonState.fail:
          IconedButton(text: "Failed", icon: Icon(Icons.cancel,color: Colors.white), color: Colors.red.shade300),
      ButtonState.success:
          IconedButton(text: "Success", icon: Icon(Icons.check_circle,color: Colors.white,), color: Colors.green.shade400)
    }, 
    onPressed: onPressed,
    state: stateTextWithIcon, sh
    ); */
  }
}
