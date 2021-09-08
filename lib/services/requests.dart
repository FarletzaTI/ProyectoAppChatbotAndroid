//@dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:app_prueba/models/agentes.dart';
import 'package:app_prueba/models/contactosagentes.dart';
import 'package:app_prueba/models/motivosrechazo.dart';
import 'package:app_prueba/models/solicitudes.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'dart:async';

//const SERVER_IP = 'http://181.198.116.210:9189/cotizadorWebAPI/api';

const SERVER_IP = 'http://192.168.168.23:8380/CotizadorWebApi/api';

class NetworkHelper {
  static Future<List<Solicitude>> attemptConsultRequest(String opc) async {
    List<Solicitude> solicitudes = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idVendedor = prefs.getInt("idVendedor");
    var token = prefs.getString("token");
    var res = await http.post(
      "$SERVER_IP/solicitudes/consultaSolicitudes",
      body: {"idvendedor": "10027", "parametroConsulta": opc},
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (res.statusCode != 200) return solicitudes;
    if (res.statusCode == 200) {
      Map<String, dynamic> consult = jsonDecode(res.body);
      if (consult.containsKey("Solicitudes")) {
        solicitudes = List<Solicitude>.from(
            consult["Solicitudes"].map((x) => Solicitude.fromJson(x)));
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
    if (res.statusCode != 200)
      throw Exception("Usuario o Contraseño no validos");
    if (res.statusCode == 200) return res.body;
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
    if (res.statusCode != 200) throw Exception("No hay agentes");
    if (res.statusCode == 200) {
      Map<String, dynamic> consult = jsonDecode(res.body);
      //if (consult.containsKey("ListaMotivos")) {
      try {
        agentes = List<ListaAgentes>.from(
            consult["ListaAgentes"].map((x) => ListaAgentes.fromJson(x)));
      } on Exception catch (e) {
        print(e.toString());
      }
      return agentes;
      // } else
      //  return agentes;
    }
  }

//llama al API de contactos de un Agente
  static Future<ContactosSegunAgente> attemptContactoAgente(
      String idagente) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<ContactosAgentes> contactosagentes = [];
    if (idagente.isEmpty)
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
    if (res.statusCode != 200) throw Exception("No hay agentes");
    if (res.statusCode == 200) {
      Map<String, dynamic> consult = jsonDecode(res.body);
      if (consult.containsKey("ContactosAgente")) {
        ContactosSegunAgente agentes = ContactosSegunAgente.fromJson(consult);
        return agentes;
      }
    }
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
    if (res.statusCode != 200) throw Exception();
    if (res.statusCode == 200) return res.body;
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
}
