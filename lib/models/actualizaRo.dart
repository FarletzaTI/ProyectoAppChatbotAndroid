//@dart=2.9
class Ro {
  String numeroRO;
  String motivoRechazo;
  Ro({this.numeroRO, this.motivoRechazo});

  Ro.fromJson(Map<String, dynamic> json) {
    numeroRO = json['NumeroRo'];
    motivoRechazo = json['motivoRechazo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['NumeroRo'] = this.motivoRechazo;
    data['motivoRechazo'] = this.numeroRO;

    return data;
  }
}
