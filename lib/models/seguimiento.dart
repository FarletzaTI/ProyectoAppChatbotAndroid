//@dart=2.9
class ClassSeguimiento {
  List<Listasoli> listasoli;

  ClassSeguimiento({this.listasoli});

  ClassSeguimiento.fromJson(Map<String, dynamic> json) {
    if (json['Listasoli'] != null) {
      listasoli = new List<Listasoli>();
      json['Listasoli'].forEach((v) {
        listasoli.add(new Listasoli.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listasoli != null) {
      data['Listasoli'] = this.listasoli.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Listasoli {
  String tarea;
  String estado;
  String fechaTarea;

  Listasoli({this.tarea, this.estado, this.fechaTarea});

  Listasoli.fromJson(Map<String, dynamic> json) {
    tarea = json['Tarea'];
    estado = json['estado'];
    fechaTarea = json['FechaTarea'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Tarea'] = this.tarea;
    data['estado'] = this.estado;
    data['FechaTarea'] = this.fechaTarea;
    return data;
  }
}
