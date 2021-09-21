//@dart=2.9

class Adjunto {
  String idsolicitud;
  String idtarea;
  String nombreArchivo;
  String linkDescarga;

  Adjunto(
      {this.idsolicitud, this.idtarea, this.nombreArchivo, this.linkDescarga});

  Adjunto.fromJson(Map<String, dynamic> json) {
    idsolicitud = json['Idsolicitud'];
    idtarea = json['Idtarea'];
    nombreArchivo = json['NombreArchivo'];
    linkDescarga = json['LinkDescarga'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Idsolicitud'] = this.idsolicitud;
    data['Idtarea'] = this.idtarea;
    data['NombreArchivo'] = this.nombreArchivo;
    data['LinkDescarga'] = this.linkDescarga;
    return data;
  }
}
