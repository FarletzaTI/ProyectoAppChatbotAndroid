//@dart=2.9
import 'dart:convert';

Naviera NavieraFromJson(String str) {
  final jsonData = json.decode(str);
  return Naviera.fromMap(jsonData);
}

String NavieraToJson(Naviera data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Naviera {
  int id;
  String nombre;

  Naviera({
    this.id,
    this.nombre,
  });

  factory Naviera.fromMap(Map<String, dynamic> json) =>
      new Naviera(id: json["id"], nombre: json["nombre"]);

  Map<String, dynamic> toMap() => {"id": id, "nombre": nombre};
}
