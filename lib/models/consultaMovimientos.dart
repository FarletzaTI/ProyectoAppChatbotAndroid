// @dart=2.9
class EntidadMov {
  int idsolicitud;
  bool regcontactarCliente;
  bool regSolicitarIE;
  bool regNegociacionE;
  bool regCotizacion;
  bool regCierre;
  bool registroCliente;
  bool registroRo;
  String medioContactoCliente;
  String medioSoliInfEmb;
  int idagente;
  String nombreAgetne;
  int idContactoagente;
  String nombreContactoAgetne;
  String telefonoContactoAgetne;
  String emailContactoAgetne;
  String ruc;
  String numeroro;
  String estado;
  int idmotivo;
  String observacion;

  EntidadMov(
      {this.idsolicitud,
      this.regcontactarCliente,
      this.regSolicitarIE,
      this.regNegociacionE,
      this.regCotizacion,
      this.regCierre,
      this.registroCliente,
      this.registroRo,
      this.medioContactoCliente,
      this.medioSoliInfEmb,
      this.idagente,
      this.nombreAgetne,
      this.idContactoagente,
      this.nombreContactoAgetne,
      this.telefonoContactoAgetne,
      this.emailContactoAgetne,
      this.ruc,
      this.numeroro,
      this.estado,
      this.idmotivo,
      this.observacion});

  EntidadMov.fromJson(Map<String, dynamic> json) {
    idsolicitud = json['idsolicitud'];
    regcontactarCliente = json['RegcontactarCliente'];
    regSolicitarIE = json['RegSolicitarIE'];
    regNegociacionE = json['RegNegociacionE'];
    regCotizacion = json['RegCotizacion'];
    regCierre = json['RegCierre'];
    registroCliente = json['RegistroCliente'];
    registroRo = json['RegistroRo'];
    medioContactoCliente = json['medioContactoCliente'];
    medioSoliInfEmb = json['medioSoliInfEmb'];
    idagente = json['idagente'];
    nombreAgetne = json['nombreAgetne'];
    idContactoagente = json['idContactoagente'];
    nombreContactoAgetne = json['nombreContactoAgetne'];
    telefonoContactoAgetne = json['telefonoContactoAgetne'];
    emailContactoAgetne = json['emailContactoAgetne'];
    ruc = json['ruc'];
    numeroro = json['numeroro'];
    estado = json['Estado'];
    idmotivo = json['idmotivo'];
    observacion = json['observacion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idsolicitud'] = this.idsolicitud;
    data['RegcontactarCliente'] = this.regcontactarCliente;
    data['RegSolicitarIE'] = this.regSolicitarIE;
    data['RegNegociacionE'] = this.regNegociacionE;
    data['RegCotizacion'] = this.regCotizacion;
    data['RegCierre'] = this.regCierre;
    data['RegistroCliente'] = this.registroCliente;
    data['RegistroRo'] = this.registroRo;
    data['medioContactoCliente'] = this.medioContactoCliente;
    data['medioSoliInfEmb'] = this.medioSoliInfEmb;
    data['idagente'] = this.idagente;
    data['nombreAgetne'] = this.nombreAgetne;
    data['idContactoagente'] = this.idContactoagente;
    data['nombreContactoAgetne'] = this.nombreContactoAgetne;
    data['telefonoContactoAgetne'] = this.telefonoContactoAgetne;
    data['emailContactoAgetne'] = this.emailContactoAgetne;
    data['ruc'] = this.ruc;
    data['numeroro'] = this.numeroro;
    data['Estado'] = this.estado;
    data['idmotivo'] = this.idmotivo;
    data['observacion'] = this.observacion;
    return data;
  }
}
