//@dart=2.9
import 'dart:convert';

Shipper shipperFromJson(String str) {
  final jsonData = json.decode(str);
  return Shipper.fromMap(jsonData);
}

String shipperToJson(Shipper data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Shipper {
  int id;
  String nombre;
  int vendedor;

  Shipper({this.id, this.nombre, this.vendedor});

  factory Shipper.fromMap(Map<String, dynamic> json) => new Shipper(
      id: json["id"], nombre: json["nombre"], vendedor: json["vendedor"]);

  Map<String, dynamic> toMap() =>
      {"id": id, "nombre": nombre, "vendedor": vendedor};
}
