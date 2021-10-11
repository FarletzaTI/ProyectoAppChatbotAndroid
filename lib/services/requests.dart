//@dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:app_prueba/models/EntidadesBASC/entidadFuncionJudicial.dart';
import 'package:app_prueba/models/agentes.dart';
import 'package:app_prueba/models/consultaMovimientos.dart';
import 'package:app_prueba/models/contactosagentes.dart';
import 'package:app_prueba/models/motivosrechazo.dart';
import 'package:app_prueba/models/seguimiento.dart';
import 'package:app_prueba/models/solicitude_model.dart';
import 'package:app_prueba/models/solicitudes.dart';
import 'package:app_prueba/models/solicitudes_Customer.dart';
import 'package:app_prueba/models/uploadRes.dart';
import 'package:app_prueba/providers/contact_customer_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'dart:async';

//const SERVER_IP = 'http://181.198.116.210:9189/cotizadorWebAPI/api'; //Pruebas
const SERVER_IP =
    'http://181.198.116.210:9187/cotizadorWebAPI/api'; //Preproduccion

const SERVER_IP_VALIDA = "http://192.168.168.23:8327/appValidacionPersonas";
//const SERVER_IP = 'http://192.168.168.23:8380/CotizadorWebApi/api'; //local

class NetworkHelper {
  static Future<List<Solicitude>> attemptConsultRequest(
      String opc, BuildContext context) async {
    List<Solicitude> solicitudes = [];
    final contactProvider =
        Provider.of<ContactCustomerprovider>(context, listen: false);
    contactProvider.emptySolicitude();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idVendedor = prefs.getInt("vendedorId");
    var token = prefs.getString("token");
    var res = await http.post(
      "$SERVER_IP/solicitudes/consultaSolicitudes",
      body: {"idvendedor": "$idVendedor", "parametroConsulta": opc},
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (res.statusCode != 200)
      return solicitudes;
    else {
      Map<String, dynamic> consult = jsonDecode(res.body);
      if (consult.containsKey("Solicitudes")) {
        solicitudes = List<Solicitude>.from(consult["Solicitudes"].map((x) {
          final solicitude = Solicitude.fromJson(x);
          contactProvider.saveSolicitude(
              SolicitudeModel(idsolicitud: solicitude.idsolicitud));
          return solicitude;
        }));
        return solicitudes;
      } else
        return solicitudes;
    }
  }

  static Future<List<Solicitudes>> attemptConsultRequestCus(
      String opc, BuildContext context) async {
    List<Solicitudes> solicitudes = [];
    final contactProvider =
        Provider.of<ContactCustomerprovider>(context, listen: false);
    contactProvider.emptySolicitude();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idcustomer = prefs.getInt("vendedorId");
    var token = prefs.getString("token");
    var res = await http.post(
      "$SERVER_IP/solicitudes/consultaSolicitudesCustomers",
      body: {"IdCustomer": "$idcustomer", "parametroConsulta": opc},
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (res.statusCode != 200)
      return solicitudes;
    else {
      Map<String, dynamic> consult = jsonDecode(res.body);
      if (consult.containsKey("Solicitudes")) {
        solicitudes = List<Solicitudes>.from(consult["Solicitudes"].map((x) {
          final solicitude = Solicitudes.fromJson(x);
          contactProvider.saveSolicitude(
              SolicitudeModel(idsolicitud: solicitude.idsolicitud));
          return solicitude;
        }));
        //Guardar en memoria - contactProvider.solicitudeModelList;  //setString (valor - llave (IdUSUSARI))
        return solicitudes;
      } else
        return solicitudes;
    }
  }

  static Future<String> attemptLogIn(String email, String password) async {
    var res = await http.post("$SERVER_IP/login/authenticate", body: {
      "Email": email,
      "Password": md5.convert(utf8.encode(password)).toString()
    });
    if (res.statusCode == 200) return res.body;

    if (res.statusCode != 200)
      throw Exception("Usuario o Contraseño no validos");
  }

//llama al API de opciones habilitadas por vendedor
  static Future<String> viewApp(String email) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var res = await http.post(
        "$SERVER_IP/solicitudes/vistaApp",
        body: {"Email": email},
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        encoding: Encoding.getByName("utf-8"),
      );
      if (res.statusCode != 200) throw Exception("vistas no encontradas");
      if (res.statusCode == 200) return res.body;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

//llama al API de motivos de rechazo
  static Future<List<ListMotivo>> attemptMotivoRechazo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<ListMotivo> motivosR = [];

    var token = prefs.getString("token");
    var res = await http.post(
      "$SERVER_IP/solicitudes/MotivoRechazo",
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (res.statusCode != 200) throw Exception("No se encontraron motivos");
    if (res.statusCode == 200) {
      Map<String, dynamic> consult = jsonDecode(res.body);
      if (consult.containsKey("ListaMotivos")) {
        motivosR = List<ListMotivo>.from(
            consult["ListaMotivos"].map((x) => ListMotivo.fromJson(x)));
        return motivosR;
      } else
        return motivosR;
    }
  }

  //llama al API de Agentes
  static Future<List<ListaAgentes>> attemptAgentes(
      String lineaNegocio, String nombrePais) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<ListaAgentes> agentes = [];

    var token = prefs.getString("token");
    var res = await http.post(
      "$SERVER_IP/solicitudes/ConsultaAgentes",
      body: {"lineaNegocio": lineaNegocio, "NombrePais": nombrePais},
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (res.statusCode != 200) return agentes;
    if (res.statusCode == 200) {
      Map<String, dynamic> consult = jsonDecode(res.body);
      try {
        agentes = List<ListaAgentes>.from(
            consult["ListaAgentes"].map((x) => ListaAgentes.fromJson(x)));
      } on Exception catch (e) {
        print(e.toString());
      }
      return agentes;
    }
  }

  static Future<List<Listasoli>> attemptSeguimiento(String idsolicitud) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Listasoli> listasoli = [];

    var token = prefs.getString("token");

    var res = await http.post(
      "$SERVER_IP/solicitudes/ConsultaSeguimiento",
      body: {"idsolicitud": idsolicitud},
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (res.statusCode != 200) return listasoli;
    if (res.statusCode == 200) {
      Map<String, dynamic> consult = jsonDecode(res.body);
      //if (consult.containsKey("ListaMotivos")) {
      try {
        listasoli = List<Listasoli>.from(
            consult["Listasoli"].map((x) => Listasoli.fromJson(x)));
      } on Exception catch (e) {}
      return listasoli;
    }
  }

  //llamada al API DE LISTA_CLINTON
  static Future<List<RespuestaConsulta>> attemptConsultaListCLinton(
      String numRuc, String nombresocial) async {
    List<RespuestaConsulta> datosListClinton = [];
    var res = await http.post(
      "$SERVER_IP_VALIDA/api/api/validarPersonaLC",
      body: {"numeroIdentificacion": numRuc, "nombreRazonSocial": nombresocial},
    );
    if (res.statusCode != 200) return datosListClinton;
    if (res.statusCode == 200) {
      Map<String, dynamic> consult = jsonDecode(res.body);
      try {
        datosListClinton = List<RespuestaConsulta>.from(
            consult["listaMensajes"].map((x) => RespuestaConsulta.fromJson(x)));
      } on Exception catch (e) {}
      return datosListClinton;
    }
  }

  //llamada al API DE SRI
  static Future<List<RespuestaConsulta>> attemptConsultaSRI(
      String numRuc, String nombresocial) async {
    List<RespuestaConsulta> datosRI = [];
    print("$SERVER_IP_VALIDA/api/validarPersonaSRI");
    var res = await http.post(
      "$SERVER_IP_VALIDA/api/validarPersonaSRI",
      body: {"numeroIdentificacion": numRuc, "nombreRazonSocial": nombresocial},
    );

    if (res.statusCode != 200) return datosRI;
    if (res.statusCode == 200) {
      Map<String, dynamic> consult = jsonDecode(res.body);
      try {
        datosRI = List<RespuestaConsulta>.from(
            consult["listaMensajes"].map((x) => RespuestaConsulta.fromJson(x)));
      } on Exception catch (e) {}
      return datosRI;
    }
  }

  //llamada al API DE FUNCION_JUDICIAL
  static Future<List<RespuestaConsulta>> attemptConsultaFuncionJudicial(
      String numRuc, String nombresocial) async {
    List<RespuestaConsulta> datosFJ = [];
    var res = await http.post(
      "$SERVER_IP_VALIDA/api/validarPersonaFJ",
      body: {"numeroIdentificacion": numRuc, "nombreRazonSocial": nombresocial},
    );
    if (res.statusCode != 200) return datosFJ;
    if (res.statusCode == 200) {
      Map<String, dynamic> consult = jsonDecode(res.body);
      try {
        datosFJ = List<RespuestaConsulta>.from(
            consult["listaMensajes"].map((x) => RespuestaConsulta.fromJson(x)));
      } on Exception catch (e) {}
      return datosFJ;
    }
  }

//llama al API de contactos de un Agente
  static Future<ContactosSegunAgente> attemptContactoAgente(
      String idagente) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<ContactosAgentes> contactosagentes = [];
    if (idagente == null || idagente == '')
      return ContactosSegunAgente(contactosAgente: List<ContactosAgentes>());
    String agenteId = idagente.split("|")[1];
    var token = prefs.getString("token");
    var res = await http.post(
      "$SERVER_IP/solicitudes/ConsultaContactosAgentes",
      body: {"idagente": agenteId},
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      Map<String, dynamic> consult = jsonDecode(res.body);
      if (consult.containsKey("ContactosAgente")) {
        ContactosSegunAgente agentes = ContactosSegunAgente.fromJson(consult);
        return agentes;
      }
    } else if (res.statusCode != 200)
      throw Exception("Error al consultar los agentes");
  }

//control de tareas segun el flujo
  static Future<String> attempUpdatecontrolTareas(
      String idTarea, String idsolicitud, String estado) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    var res = await http.post(
      "$SERVER_IP/solicitudes/RegistroTareas",
      body: {"Idsolicitud": idsolicitud, "IdTarea": idTarea, "Estado": estado},
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      encoding: Encoding.getByName("utf-8"),
    );
    if (res.statusCode != 200)
      throw Exception("error en el proceso de control de tareas");
    if (res.statusCode == 200) return res.body;
  }

  //Actualizar Numero de Ro
  static Future<String> attempUpdateNumeroRo(
      String numeroRo, String idsolicitud) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    var res = await http.post(
      "$SERVER_IP/solicitudes/RegistroRo",
      body: {"ro": numeroRo, "idsoliciud": idsolicitud},
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      encoding: Encoding.getByName("utf-8"),
    );
    if (res.statusCode != 200)
      throw Exception("error en el proceso de actualizar ro");
    if (res.statusCode == 200) return res.body;
  }

  //Actualizar motivo de Rechazo
  static Future<String> attempUpdateMotivoRechazo(
      String motivo,
      String idsolicitud,
      String idrechazo,
      String idtarea,
      String estado) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    var res = await http.post(
      "$SERVER_IP/solicitudes/UpdateMotivoRechazo",
      body: {
        "idsoliciud": idsolicitud,
        "IdMotivoRechazo": idrechazo,
        "MotivoRechazo": motivo,
        "Estado": estado,
        "IdTarea": idtarea
      },
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      encoding: Encoding.getByName("utf-8"),
    );
    if (res.statusCode != 200)
      throw Exception("error en el proceso de actualizar ro");
    if (res.statusCode == 200) return res.body;
  }

  static Future<String> enviarArchivo(
      String path, String solicitudId, String tareaId) async {
    if (path == '') return null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    Map<String, dynamic> consult;
    var request = http.MultipartRequest(
        'POST', Uri.parse("$SERVER_IP/solicitudes/upload"));
    request.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    request.files.add(await http.MultipartFile.fromPath('file', path));
    request.fields['Idsolicitud'] = solicitudId;
    request.fields['Idtarea'] = tareaId;

    http.Response response =
        await http.Response.fromStream(await request.send());
    return response.body;
  }

  static Future<String> obtenerCatalogos(Map<String, dynamic> catalogos) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var res = await http.post(
      "$SERVER_IP/catalogos/instruccion",
      body: json.encode(catalogos),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      encoding: Encoding.getByName("utf-8"),
    );
    if (res.statusCode == 200) return res.body;

    if (res.statusCode != 200) //print(catalogos);
      throw Exception();
  }

  static Future<String> enviarInstruccion(
      Map<String, dynamic> instruccion) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var res = await http.post(
      "$SERVER_IP/instruccion",
      body: json.encode(instruccion),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      encoding: Encoding.getByName("utf-8"),
    );
    if (res.statusCode != 200) throw Exception();
    if (res.statusCode == 200) return res.body;
  }

//Api para guardar los movimientos realizados por el usuario
  static Future<String> attempGuardarMovimientos(
      String idsolicitud,
      String metodo,
      String paso,
      String idagente,
      String nombagente,
      String idContactAg,
      String nombContactAg,
      String telContactAg,
      String emailContactAg,
      String estado,
      String idmotivo,
      String observacion,
      String numruc,
      String numRo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    var res = await http.post(
      "$SERVER_IP/solicitudes/guardarMovimientos",
      body: {
        "IDSOLICITUD": idsolicitud,
        "METODO": metodo,
        "PASO": paso,
        "IDAGENTE": idagente,
        "NOMBREAG": nombagente,
        "IDCONTACTOAG": idContactAg,
        "NOMBRECTCAG": nombContactAg,
        "TELEFONOCTAG": telContactAg,
        "EMAILCTAG": emailContactAg,
        "ESTADO": estado,
        "IDMOTIVO": idmotivo,
        "OBSERVACION": observacion,
        "RUC": numruc,
        "NUM_RO": numRo
      },
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      encoding: Encoding.getByName("utf-8"),
    );
    if (res.statusCode != 200)
      throw Exception(
          "error en el proceso de ingreso/update de movimientosApp");
    if (res.statusCode == 200) return res.body;
  }

  //Api para consultar los movimientos realizados por el usuario
  static Future<EntidadMov> attemptConsultMovimientos(
      String idsolicitud, BuildContext context) async {
    EntidadMov registro;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var res = await http.post(
      "$SERVER_IP/solicitudes/ConsultaMovimientosGuardados",
      body: {"Idsoliciud": idsolicitud},
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (res.statusCode != 200)
      return registro;
    else {
      Map<String, dynamic> consult = jsonDecode(res.body);
      EntidadMov registro = EntidadMov.fromJson(consult);
      return registro;
    }
  }
}
