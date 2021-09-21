//@dart=2.9
import 'dart:convert';

Puerto puertoFromJson(String str) {
  final jsonData = json.decode(str);
  return Puerto.fromMap(jsonData);
}

String puertoToJson(Puerto data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Puerto {
  int id;
  String nombre;
  String codPais;

  Puerto({
    this.id,
    this.nombre,
    this.codPais
  });

  factory Puerto.fromMap(Map<String, dynamic> json) =>
      new Puerto(id: json["id"], nombre: json["nombre"], codPais: json["codPais"]);

  Map<String, dynamic> toMap() => {"id": id, "nombre": nombre, "codPais": codPais};
}
