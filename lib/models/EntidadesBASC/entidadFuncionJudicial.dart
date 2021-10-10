// @dart=2.9
class RespuestaConsulta {
  String entidadConsutada;
  bool resultadoValidacion;
  List<String> listaMensajes;

  RespuestaConsulta(
      {this.entidadConsutada, this.resultadoValidacion, this.listaMensajes});

  RespuestaConsulta.fromJson(Map<String, dynamic> json) {
    entidadConsutada = json['entidadConsutada'];
    resultadoValidacion = json['resultadoValidacion'];
    listaMensajes = json['listaMensajes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entidadConsutada'] = this.entidadConsutada;
    data['resultadoValidacion'] = this.resultadoValidacion;
    data['listaMensajes'] = this.listaMensajes;
    return data;
  }
}
