// @dart=2.9

class ContactosSegunAgente {
  List<ContactosAgentes> contactosAgente;

  ContactosSegunAgente({this.contactosAgente});

  ContactosSegunAgente.fromJson(Map<String, dynamic> json) {
    if (json['ContactosAgente'] != null) {
      contactosAgente = new List<ContactosAgentes>();
      json['ContactosAgente'].forEach((v) {
        contactosAgente.add(new ContactosAgentes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contactosAgente != null) {
      data['ContactosAgente'] =
          this.contactosAgente.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactosAgentes {
  int idagente;
  int idpersona;
  String tipoCarga;
  String nombre;
  List<MediosdeContacto> mediosdeContacto;

  ContactosAgentes(
      {this.idagente,
      this.idpersona,
      this.tipoCarga,
      this.nombre,
      this.mediosdeContacto});

  ContactosAgentes.fromJson(Map<String, dynamic> json) {
    idagente = json['idagente'];
    idpersona = json['idpersona'];
    tipoCarga = json['tipoCarga'];
    nombre = json['nombre'];
    if (json['MediosdeContacto'] != null) {
      mediosdeContacto = new List<MediosdeContacto>();
      json['MediosdeContacto'].forEach((v) {
        mediosdeContacto.add(new MediosdeContacto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idagente'] = this.idagente;
    data['idpersona'] = this.idpersona;
    data['tipoCarga'] = this.tipoCarga;
    data['nombre'] = this.nombre;
    if (this.mediosdeContacto != null) {
      data['MediosdeContacto'] =
          this.mediosdeContacto.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MediosdeContacto {
  String codigo;
  String descripcion;
  String valor;

  MediosdeContacto({this.codigo, this.descripcion, this.valor});

  MediosdeContacto.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'];
    descripcion = json['descripcion'];
    valor = json['valor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo'] = this.codigo;
    data['descripcion'] = this.descripcion;
    data['valor'] = this.valor;
    return data;
  }
}
