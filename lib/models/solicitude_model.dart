class SolicitudeModel {
  int idsolicitud;
  bool btncontinuar;
  bool opcion2;
  String numRo;
  bool opcFinalizar;

  SolicitudeModel(
      {required this.idsolicitud,
      this.btncontinuar = true,
      this.numRo = "",
      this.opcFinalizar = true,
      this.opcion2 = true});

  SolicitudeModel copyWith(
          {bool? btncontinuar,
          bool? opcion2,
          String? numRo,
          bool? opcFinalizar}) =>
      SolicitudeModel(
          idsolicitud: this.idsolicitud,
          btncontinuar: btncontinuar ?? this.btncontinuar,
          numRo: numRo ?? this.numRo,
          opcFinalizar: opcFinalizar ?? this.opcFinalizar,
          opcion2: opcion2 ?? this.opcion2);
}
