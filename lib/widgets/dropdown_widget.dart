// @dart=2.9
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final IconData prefixIcon;
  final Function onChanged;
  final String hintText;
  final List<DropdownMenuItem<T>> listaItems;
  final T selectedItem;
  const CustomDropdown({ Key key, this.prefixIcon, this.onChanged, this.hintText, this.listaItems, this.selectedItem }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      validator: (value) => value == null ? "Campo requerido" : null,
      hint: Text(hintText),
      isExpanded: true,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.all(16),
      ),
      value: selectedItem,
      items: listaItems,
      onChanged: onChanged,
    );    
  }
}