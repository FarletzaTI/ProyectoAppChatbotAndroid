// @dart=2.9
class Agentes {
  List<ListaAgentes> listaAgentes;

  Agentes({this.listaAgentes});

  Agentes.fromJson(Map<String, dynamic> json) {
    if (json['ListaAgentes'] != null) {
      listaAgentes = new List<ListaAgentes>();
      json['ListaAgentes'].forEach((v) {
        listaAgentes.add(new ListaAgentes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listaAgentes != null) {
      data['ListaAgentes'] = this.listaAgentes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListaAgentes {
  int idagente;
  String nombreAggente;
  int personaId;

  ListaAgentes({this.idagente, this.nombreAggente, this.personaId});

  ListaAgentes.fromJson(Map<String, dynamic> json) {
    idagente = json['idagente'];
    nombreAggente = json['nombreAggente'];
    personaId = json['PersonaId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idagente'] = this.idagente;
    data['nombreAggente'] = this.nombreAggente;
    data['PersonaId'] = this.personaId;
    return data;
  }
}
