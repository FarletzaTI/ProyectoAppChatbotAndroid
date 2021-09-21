/* import 'package:flutter/material.dart';

class Contenedor {
  int id;
  String name;

  Contenedor(this.id, this.name);

  static List<Contenedor> getCompanies() {
    return <Contenedor>[
      Contenedor(1, '20\' GP'),
      Contenedor(2, '40\' GP'),
      Contenedor(3, '40\' HC'),
      Contenedor(4, '20\' FLAT RACK'),
      Contenedor(5, '40\' FLAT RACK'),
      Contenedor(6, '20\' OPEN TOP'),
      Contenedor(7, '40\' OPEN TOP'),
      Contenedor(8, '20\' REEFER'),
      Contenedor(9, '40\' REEFER'),
      Contenedor(31, '40\' NOR'),
      Contenedor(32, '20\' NOR'),
      Contenedor(34,"45 HC")
    ];
  }

  static List<DropdownMenuItem<Contenedor>> buildDropdownMenuItems() {
    List<DropdownMenuItem<Contenedor>> items = [];
    for (Contenedor company in getCompanies()) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(
            company.name,
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
} */