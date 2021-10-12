// To parse this JSON data, do
//
//     final respuestaConsulta = respuestaConsultaFromJson(jsonString);

import 'dart:convert';

RespuestaConsulta respuestaConsultaFromJson(String str) =>
    RespuestaConsulta.fromJson(json.decode(str));

String respuestaConsultaToJson(RespuestaConsulta data) =>
    json.encode(data.toJson());

class RespuestaConsulta {
  RespuestaConsulta({
    this.entidadConsutada,
    this.resultadoValidacion = false,
    this.listaMensajes = const [],
  });

  String? entidadConsutada;
  bool resultadoValidacion;
  List<String> listaMensajes;

  factory RespuestaConsulta.fromJson(Map<String, dynamic> json) =>
      RespuestaConsulta(
        entidadConsutada: json["entidadConsutada"],
        resultadoValidacion: json["resultadoValidacion"],
        listaMensajes: List<String>.from(json["listaMensajes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "entidadConsutada": entidadConsutada,
        "resultadoValidacion": resultadoValidacion,
        "listaMensajes": List<dynamic>.from(listaMensajes.map((x) => x)),
      };
}
