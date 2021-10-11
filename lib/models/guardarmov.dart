// @dart=2.9

// To parse this JSON data, do
//
//     final guardarmovimientos = guardarmovimientosFromJson(jsonString);

import 'dart:convert';

Guardarmovimientos guardarmovimientosFromJson(String str) =>
    Guardarmovimientos.fromJson(json.decode(str));

String guardarmovimientosToJson(Guardarmovimientos data) =>
    json.encode(data.toJson());

class Guardarmovimientos {
  Guardarmovimientos({
    this.idsolicitud,
    this.metodo,
    this.paso,
    this.idagente,
    this.nombreag,
    this.idcontactoag,
    this.nombrectcag,
    this.telefonoctag,
    this.emailctag,
    this.estado,
    this.idmotivo,
    this.observacion,
    this.ruc,
    this.numRo,
  });

  int idsolicitud;
  String metodo;
  int paso;
  int idagente;
  String nombreag;
  int idcontactoag;
  String nombrectcag;
  String telefonoctag;
  String emailctag;
  String estado;
  int idmotivo;
  String observacion;
  String ruc;
  String numRo;

  factory Guardarmovimientos.fromJson(Map<String, dynamic> json) =>
      Guardarmovimientos(
        idsolicitud: json["IDSOLICITUD"],
        metodo: json["METODO"],
        paso: json["PASO"],
        idagente: json["IDAGENTE"],
        nombreag: json["NOMBREAG"],
        idcontactoag: json["IDCONTACTOAG"],
        nombrectcag: json["NOMBRECTCAG"],
        telefonoctag: json["TELEFONOCTAG"],
        emailctag: json["EMAILCTAG"],
        estado: json["ESTADO"],
        idmotivo: json["IDMOTIVO"],
        observacion: json["OBSERVACION"],
        ruc: json["RUC"],
        numRo: json["NUM_RO"],
      );

  Map<String, dynamic> toJson() => {
        "IDSOLICITUD": idsolicitud,
        "METODO": metodo,
        "PASO": paso,
        "IDAGENTE": idagente,
        "NOMBREAG": nombreag,
        "IDCONTACTOAG": idcontactoag,
        "NOMBRECTCAG": nombrectcag,
        "TELEFONOCTAG": telefonoctag,
        "EMAILCTAG": emailctag,
        "ESTADO": estado,
        "IDMOTIVO": idmotivo,
        "OBSERVACION": observacion,
        "RUC": ruc,
        "NUM_RO": numRo,
      };
}
