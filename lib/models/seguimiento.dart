//@dart=2.9

class ListaSeguimiento {
  List<Listasoli> listasoli;

  ListaSeguimiento({this.listasoli});

  ListaSeguimiento.fromJson(Map<String, dynamic> json) {
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
  int idSolicitud;
  String nombre;
  String estado;
  String ro;
  String fechaIngresoSol;
  String fechaTarea;
  String tarea;

  Listasoli(
      {this.idSolicitud,
      this.nombre,
      this.estado,
      this.ro,
      this.fechaIngresoSol,
      this.fechaTarea,
      this.tarea});

  Listasoli.fromJson(Map<String, dynamic> json) {
    idSolicitud = json['Id_solicitud'];
    nombre = json['nombre'];
    estado = json['estado'];
    ro = json['ro'];
    fechaIngresoSol = json['FechaIngresoSol'];
    fechaTarea = json['FechaTarea'];
    tarea = json['Tarea'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id_solicitud'] = this.idSolicitud;
    data['nombre'] = this.nombre;
    data['estado'] = this.estado;
    data['ro'] = this.ro;
    data['FechaIngresoSol'] = this.fechaIngresoSol;
    data['FechaTarea'] = this.fechaTarea;
    data['Tarea'] = this.tarea;
    return data;
  }
}
