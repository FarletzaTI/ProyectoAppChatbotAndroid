//@dart=2.9
import 'dart:convert';

import 'package:flutter/material.dart';

Contenedor contenedorFromJson(String str) {
  final jsonData = json.decode(str);
  return Contenedor.fromMap(jsonData);
}

String contenedorToJson(Contenedor data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Contenedor {
  int id;
  String nombre;

  Contenedor({this.id, this.nombre});

  factory Contenedor.fromMap(Map<String, dynamic> json) =>
      new Contenedor(id: json["id"], nombre: json["nombre"]);

  Map<String, dynamic> toMap() => {"id": id, "nombre": nombre};

  static List<DropdownMenuItem<Contenedor>> buildDropdownMenuItems(List<Contenedor> contenedoresList) {
    List<DropdownMenuItem<Contenedor>> items = [];
    for (Contenedor cont in contenedoresList) {
      items.add(
        DropdownMenuItem(
          value: cont,
          child: Text(
            cont.nombre,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
                color: Colors.indigo[400]),
          ),
        ),
      );
    }
    return items;
  }
}
