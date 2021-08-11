// @dart=2.9
class Carga {
  String descripcion;
  int tipoCarga;
  int cantidad;
  double temperatura;
  double ventilacion;
  double humedad;

  Carga(
      {this.tipoCarga,
      this.cantidad,
      this.temperatura,
      this.ventilacion,
      this.humedad,
      this.descripcion});

  Carga.fromJson(Map<String, dynamic> json) {
    tipoCarga = json['tipoCarga'];
    cantidad = json['cantidad'];
    temperatura = json['temperatura'];
    ventilacion = json['ventilacion'];
    humedad = json['humedad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tipoCarga'] = this.tipoCarga;
    data['cantidad'] = this.cantidad;
    data['temperatura'] = this.temperatura;
    data['ventilacion'] = this.ventilacion;
    data['humedad'] = this.humedad;
    return data;
  }
}