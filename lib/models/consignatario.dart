//@dart=2.9
import 'dart:convert';

Consignatario consignatarioFromJson(String str) {
  final jsonData = json.decode(str);
  return Consignatario.fromMap(jsonData);
}

String consignatarioToJson(Consignatario data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Consignatario {
  int id;
  String nombre;

  Consignatario({this.id, this.nombre});

  factory Consignatario.fromMap(Map<String, dynamic> json) =>
      new Consignatario(id: json["id"], nombre: json["nombre"]);

  Map<String, dynamic> toMap() => {"id": id, "nombre": nombre};
}
