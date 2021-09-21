//@dart=2.9

class ViewAppModel {
  final String codigoVista;
  final String descripcion;

  ViewAppModel({this.codigoVista, this.descripcion});

  factory ViewAppModel.fromJson(Map<String, dynamic> json) => ViewAppModel(
      codigoVista: json["codigoVista"], descripcion: json["descripcion"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigoVista'] = this.codigoVista;
    data['descripcion'] = this.descripcion;
    return data;
  }
}
