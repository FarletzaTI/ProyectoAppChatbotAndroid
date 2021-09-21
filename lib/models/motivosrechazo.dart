//@dart=2.9

class motivosdeRechazo {
  List<ListMotivo> listaMotivos;

  motivosdeRechazo({this.listaMotivos});

  motivosdeRechazo.fromJson(Map<String, dynamic> json) {
    if (json['ListaMotivos'] != null) {
      listaMotivos = [];
      json['ListaMotivos'].forEach((v) {
        listaMotivos.add(new ListMotivo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listaMotivos != null) {
      data['ListaMotivos'] = this.listaMotivos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListMotivo {
  int idmotivo;
  String descripcion;

  ListMotivo({this.idmotivo, this.descripcion});

  ListMotivo.fromJson(Map<String, dynamic> json) {
    idmotivo = json['idmotivo'];
    descripcion = json['descripcion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idmotivo'] = this.idmotivo;
    data['descripcion'] = this.descripcion;
    return data;
  }
}
