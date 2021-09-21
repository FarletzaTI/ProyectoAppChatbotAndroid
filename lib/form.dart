// @dart=2.9
import 'package:app_prueba/const/gradient.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomTextForm extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final Function(String) function;
  final Function(String) changed;
  final VoidCallback onPressed;
  final TextEditingController controller;
  final Function(String) validator;
  final bool obscure  ; 

  const CustomTextForm(
      {this.hintText = "",
      this.controller = null,
      this.onPressed,
      this.prefixIcon,
      this.keyboardType,
      this.function,
      this.changed,
      this.obscure = false, this.validator,
       });
  @override
  Widget build(BuildContext context) {
    return TextFormField(  
      validator: validator,
      obscureText: obscure,
      controller: controller,
      focusNode: FocusNode(canRequestFocus: false),
      onTap: onPressed,
      onChanged: (input) => changed(input),
      onSaved: (input) => function(input),
      style: TextStyle(
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
          color: primaryColor),
      decoration: InputDecoration(
        suffixIcon: Icon(MdiIcons.exclamation,color: Colors.white,),     
       
        prefixIcon: Icon(prefixIcon),
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
            color: Colors.black26),
        hintText: hintText,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,        
        isDense: true,
        contentPadding: EdgeInsets.all(16),
      ),
      autofocus: false,
      keyboardType: keyboardType,

    );
  }
}
