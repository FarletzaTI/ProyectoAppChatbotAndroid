//@dart=2.9

class ApiResponse {
  Respuesta respuesta;

  ApiResponse({this.respuesta});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    respuesta = json['respuesta'] != null
        ? new Respuesta.fromJson(json['respuesta'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.respuesta != null) {
      data['respuesta'] = this.respuesta.toJson();
    }
    return data;
  }
}

class Respuesta {
  bool resultado;
  String mensaje;
  Datos datos;

  Respuesta({this.resultado, this.mensaje, this.datos});

  Respuesta.fromJson(Map<String, dynamic> json) {
    resultado = json['resultado'];
    mensaje = json['mensaje'];
    datos = json['datos'] != null ? new Datos.fromJson(json['datos']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultado'] = this.resultado;
    data['mensaje'] = this.mensaje;
    if (this.datos != null) {
      data['datos'] = this.datos.toJson();
    }
    return data;
  }
}

class Datos {
  ResponseItem consignatario;
  ResponseItem contenedor;
  ResponseItem naviera;
  ResponseItem puerto;
  ResponseItem shipper;

  Datos(
      {this.consignatario,
      this.contenedor,
      this.naviera,
      this.puerto,
      this.shipper});

  Datos.fromJson(Map<String, dynamic> json) {
    consignatario = json['consignatario'] != null
        ? new ResponseItem.fromJson(json['consignatario'])
        : null;
    contenedor = json['contenedor'] != null
        ? new ResponseItem.fromJson(json['contenedor'])
        : null;
    naviera = json['naviera'] != null
        ? new ResponseItem.fromJson(json['naviera'])
        : null;
    puerto = json['puerto'] != null
        ? new ResponseItem.fromJson(json['puerto'])
        : null;
    shipper = json['shipper'] != null
        ? new ResponseItem.fromJson(json['shipper'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.consignatario != null) {
      data['consignatario'] = this.consignatario.toJson();
    }
    if (this.contenedor != null) {
      data['contenedor'] = this.contenedor.toJson();
    }
    if (this.naviera != null) {
      data['naviera'] = this.naviera.toJson();
    }
    if (this.puerto != null) {
      data['puerto'] = this.puerto.toJson();
    }
    if (this.shipper != null) {
      data['shipper'] = this.shipper.toJson();
    }
    return data;
  }
}

class ResponseItem {
  int version;
  List<dynamic> datos;

  ResponseItem({this.version, this.datos});

  ResponseItem.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    if (json['datos'] != null) {
      datos = [];
      json['datos'].forEach((v) {
        datos.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this.version;
    if (this.datos != null) {
      data['datos'] = this.datos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
