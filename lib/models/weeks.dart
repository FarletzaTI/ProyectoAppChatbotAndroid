import 'package:app_prueba/const/gradient.dart';
import 'package:flutter/material.dart';
import 'package:week_of_year/week_of_year.dart';

class Week {
  int id;
  String name;

  Week(this.id, this.name);

  static List<Week> getWeeks() {
    final date = DateTime.now();
    int weekNumber = date.weekOfYear; // Get the iso week of year
    List<Week> listaSemanas = [];
        
    for (var i = 0; i < 7; i++) {
      listaSemanas.add(Week(weekNumber+i,'Semana ${weekNumber+i}'));
    }
    return listaSemanas;
  }

  static List<DropdownMenuItem<Week>> buildDropdownMenuItems() {
    List<DropdownMenuItem<Week>> items = [];
    for (Week company in getWeeks()) {
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