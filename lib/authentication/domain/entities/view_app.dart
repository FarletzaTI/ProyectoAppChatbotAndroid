class ViewAppModel {
  final String codigoVista;
  final String descripcion;

  ViewAppModel({required this.codigoVista, required this.descripcion});

  factory ViewAppModel.fromJson(Map<String, dynamic> json) => ViewAppModel(
      codigoVista: json["codigoVista"], descripcion: json["descripcion"]);
}
