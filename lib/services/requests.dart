//@dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

const SERVER_IP = 'http://181.198.116.210:9189/cotizadorWebAPI/api';

class NetworkHelper {
  static Future<String> attemptLogIn(String email, String password) async {
    var res = await http.post("$SERVER_IP/login/authenticate", body: {
      "Email": email,
      "Password": md5.convert(utf8.encode(password)).toString()
    });
    if (res.statusCode != 200)
      throw Exception("Usuario o Contraseño no validos");
    if (res.statusCode == 200) return res.body;
  }

  static Future<String> viewApp(String email) async {
    var res = await http.post("$SERVER_IP/vistaApp", body: {
      "Email": email,
    });

    if (res.statusCode != 200) throw Exception("Vistas no cargadas");
    if (res.statusCode == 200) return res.body;
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
