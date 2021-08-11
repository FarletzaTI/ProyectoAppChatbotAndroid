//@dart=2.9
import 'dart:convert';

Catalogo catalogoFromJson(String str) {
  final jsonData = json.decode(str);
  return Catalogo.fromMap(jsonData);
}

String catalogoToJson(Catalogo data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Catalogo {
  int id;
  String nombre;
  int version;
  String fecha;

  Catalogo({
    this.id,
    this.nombre,
    this.version,
    this.fecha,
  });

  factory Catalogo.fromMap(Map<String, dynamic> json) => new Catalogo(
        id: json["id"],
        nombre: json["nombre"],
        version: json["version"],
        fecha: json["fecha"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "version": version,
        "fecha": fecha,
      };
}
