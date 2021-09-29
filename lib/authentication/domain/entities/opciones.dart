//@dart=2.9

import 'package:app_prueba/authentication/domain/entities/view_app.dart';

class vistaDisponible {
  OpcionesModel vistas;

  vistaDisponible({this.vistas});

  vistaDisponible.fromJson(Map<String, dynamic> json) {
    vistas = json['Vistas'] != null
        ? new OpcionesModel.fromJson(json['Vistas'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vistas != null) {
      data['Vistas'] = this.vistas.toJson();
    }
    return data;
  }
}

class OpcionesModel {
  List<ViewAppModel> vistaopciones = [];

  OpcionesModel({this.vistaopciones});

  OpcionesModel.fromJson(Map<String, dynamic> json) {
    if (json['codigoVista'] != null) {
      json['vistaopciones'].forEach((v) {
        vistaopciones.add(new ViewAppModel.fromJson(v));
      });
    }
    if (json['descripcion'] != null) {
      json['descripcion'].forEach((v) {
        vistaopciones.add(new ViewAppModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vistaopciones != null) {
      data['vistaopciones'] =
          this.vistaopciones.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
