//@dart=2.9
class SolicitudCustomer {
  bool resultado;
  String mensaje;
  List<Solicitudes> solicitudes;

  SolicitudCustomer({this.resultado, this.mensaje, this.solicitudes});

  SolicitudCustomer.fromJson(Map<String, dynamic> json) {
    resultado = json['resultado'];
    mensaje = json['mensaje'];
    if (json['Solicitudes'] != null) {
      solicitudes = new List<Solicitudes>();
      json['Solicitudes'].forEach((v) {
        solicitudes.add(new Solicitudes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultado'] = this.resultado;
    data['mensaje'] = this.mensaje;
    if (this.solicitudes != null) {
      data['Solicitudes'] = this.solicitudes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Solicitudes {
  int idsolicitud;
  String lineaNegocio;
  String paisOrigen;
  String paisDestino;
  String tipoTransporte;
  String estado;
  String idCliente;
  int idProspecto;
  String comentario;
  String fechaHoraRegistro;
  String email;
  String ruc;
  String telefono;
  String nombre;
  String vendedor;

  Solicitudes(
      {this.idsolicitud,
      this.lineaNegocio,
      this.paisOrigen,
      this.paisDestino,
      this.tipoTransporte,
      this.estado,
      this.idCliente,
      this.idProspecto,
      this.comentario,
      this.fechaHoraRegistro,
      this.email,
      this.ruc,
      this.telefono,
      this.nombre,
      this.vendedor});

  Solicitudes.fromJson(Map<String, dynamic> json) {
    idsolicitud = json['Idsolicitud'];
    lineaNegocio = json['LineaNegocio'];
    paisOrigen = json['PaisOrigen'];
    paisDestino = json['PaisDestino'];
    tipoTransporte = json['TipoTransporte'];
    estado = json['Estado'];
    idCliente = json['Id_cliente'];
    idProspecto = json['Id_Prospecto'];
    comentario = json['Comentario'];
    fechaHoraRegistro = json['FechaHoraRegistro'];
    email = json['Email'];
    ruc = json['Ruc'];
    telefono = json['Telefono'];
    nombre = json['nombre'];
    vendedor = json['Vendedor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Idsolicitud'] = this.idsolicitud;
    data['LineaNegocio'] = this.lineaNegocio;
    data['PaisOrigen'] = this.paisOrigen;
    data['PaisDestino'] = this.paisDestino;
    data['TipoTransporte'] = this.tipoTransporte;
    data['Estado'] = this.estado;
    data['Id_cliente'] = this.idCliente;
    data['Id_Prospecto'] = this.idProspecto;
    data['Comentario'] = this.comentario;
    data['FechaHoraRegistro'] = this.fechaHoraRegistro;
    data['Email'] = this.email;
    data['Ruc'] = this.ruc;
    data['Telefono'] = this.telefono;
    data['nombre'] = this.nombre;
    data['Vendedor'] = this.vendedor;
    return data;
  }
}
