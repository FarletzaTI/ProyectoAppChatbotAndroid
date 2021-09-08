class Solicitude {
  Solicitude({
    required this.idsolicitud,
    required this.lineaNegocio,
    required this.paisOrigen,
    required this.paisDestino,
    required this.tipoTransporte,
    required this.estado,
    required this.idCliente,
    required this.idProspecto,
    this.comentario,
    required this.fechaHoraRegistro,
    required this.email,
    required this.ruc,
    required this.telefono,
    required this.nombre,
  });

  int idsolicitud;
  String lineaNegocio;
  String paisOrigen;
  String paisDestino;
  String tipoTransporte;
  String estado;
  String idCliente;
  int idProspecto;
  String? comentario;
  DateTime fechaHoraRegistro;
  String email;
  String ruc;
  String telefono;
  String nombre;

  factory Solicitude.fromJson(Map<String, dynamic> json) => Solicitude(
    idsolicitud: json["Idsolicitud"],
    lineaNegocio: json["LineaNegocio"],
    paisOrigen: json["PaisOrigen"],
    paisDestino: json["PaisDestino"],
    tipoTransporte: json["TipoTransporte"],
    estado: json["Estado"],
    idCliente: json["Id_cliente"],
    idProspecto: json["Id_Prospecto"],
    comentario: json["Comentario"],
    fechaHoraRegistro: DateTime.parse(json["FechaHoraRegistro"]),
    email: json["Email"],
    ruc: json["Ruc"],
    telefono: json["Telefono"],
    nombre: json["nombre"],
  );

  Map<String, dynamic> toJson() => {
    "Idsolicitud": idsolicitud,
    "LineaNegocio": lineaNegocio,
    "PaisOrigen": paisOrigen,
    "PaisDestino": paisDestino,
    "TipoTransporte": tipoTransporte,
    "Estado": estado,
    "Id_cliente": idCliente,
    "Id_Prospecto": idProspecto,
    "Comentario": comentario,
    "FechaHoraRegistro": fechaHoraRegistro.toIso8601String(),
    "Email": email,
    "Ruc": ruc,
    "Telefono": telefono,
    "nombre": nombre,
  };
}
