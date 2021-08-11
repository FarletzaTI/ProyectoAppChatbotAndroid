//@dart=2.9
import 'carga.dart';

class InstruccionEmbarque {
  int shipperId;
  String producto;
  String codeHS;
  int numeroSemana;
  int navieraId;
  int puertoOrigenId;
  int puertoDestinoId;
  String zipCode;
  bool hbl;
  bool mbl;
  String condicionFlete;
  int consignatarioId;
  String contrato;
  List<Carga> carga;

  InstruccionEmbarque(
      {this.shipperId,
      this.producto,
      this.codeHS,
      this.numeroSemana,
      this.navieraId,
      this.puertoOrigenId,
      this.puertoDestinoId,
      this.zipCode,
      this.hbl,
      this.mbl,
      this.condicionFlete,
      this.consignatarioId,
      this.contrato,
      this.carga});

  InstruccionEmbarque.fromJson(Map<String, dynamic> json) {
    shipperId = json['shipperId'];
    producto = json['producto'];
    codeHS = json['codeHS'];
    numeroSemana = json['numeroSemana'];
    navieraId = json['navieraId'];
    puertoOrigenId = json['puertoOrigenId'];
    puertoDestinoId = json['puertoDestinoId'];
    zipCode = json['zipCode'];
    hbl = json['hbl'];
    mbl = json['mbl'];
    condicionFlete = json['condicionFlete'];
    consignatarioId = json['consignatarioId'];
    contrato = json['contrato'];
    if (json['carga'] != null) {
      carga = [];
      json['carga'].forEach((v) {
        carga.add(new Carga.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shipperId'] = this.shipperId;
    data['producto'] = this.producto;
    data['codeHS'] = this.codeHS;
    data['numeroSemana'] = this.numeroSemana;
    data['navieraId'] = this.navieraId;
    data['puertoOrigenId'] = this.puertoOrigenId;
    data['puertoDestinoId'] = this.puertoDestinoId;
    data['zipCode'] = this.zipCode;
    data['hbl'] = this.hbl;
    data['mbl'] = this.mbl;
    data['condicionFlete'] = this.condicionFlete;
    data['consignatarioId'] = this.consignatarioId;
    data['contrato'] = this.contrato;
    if (this.carga != null) {
      data['carga'] = this.carga.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
