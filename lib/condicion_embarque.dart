import 'package:app_prueba/const/gradient.dart';
import 'package:flutter/material.dart';

class ConEmbarque {
  int id;
  String name;

  ConEmbarque(this.id, this.name);

  static List<ConEmbarque> getCompanies() {
    return <ConEmbarque>[
      ConEmbarque(1, 'PP'),
      ConEmbarque(2, 'CC'),      
    ];
  }

  static List<DropdownMenuItem<ConEmbarque>> buildDropdownMenuItems() {
    List<DropdownMenuItem<ConEmbarque>> items = [];
    for (ConEmbarque company in getCompanies()) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(
            company.name,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
                color: primaryColor),
          ),
        ),
      );
    }
    return items;
  }
}