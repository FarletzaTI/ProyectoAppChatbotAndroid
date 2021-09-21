//@dart=2.9
import 'dart:convert';

import 'package:app_prueba/models/consignatario.dart';
import 'package:app_prueba/models/contenedor.dart';
import 'package:app_prueba/models/naviera.dart';
import 'package:app_prueba/models/puerto.dart';
import 'package:app_prueba/models/shipper.dart';
import 'package:app_prueba/services/database.dart';

import 'models/api_response/api_catalogos.dart';

class Utils {
  static actualizarCatalogos(ApiResponse response) {
    List<Consignatario> consigList = [];
    List<Contenedor> contenedorList = [];
    List<Naviera> navieraList = [];
    List<Puerto> puertoList = [];
    List<Shipper> shipperList = [];
    final date = DateTime.now();
    String dateNow = "${date.year}/${date.month}/${date.day}";

    response.respuesta.datos.consignatario.datos.forEach((element) {
      consigList.add(Consignatario.fromMap(element));
    });
    response.respuesta.datos.contenedor.datos.forEach((element) {
      contenedorList.add(Contenedor.fromMap(element));
    });
    response.respuesta.datos.naviera.datos.forEach((element) {
      navieraList.add(Naviera.fromMap(element));
    });
    response.respuesta.datos.puerto.datos.forEach((element) {
      puertoList.add(Puerto.fromMap(element));
    });
    response.respuesta.datos.shipper.datos.forEach((element) {
      shipperList.add(Shipper.fromMap(element));
    });
    DBProvider.db.updateCatalogos(dateNow);
    DBProvider.db.insertConsignatario(consigList);
    DBProvider.db.insertContenedor(contenedorList);
    DBProvider.db.insertNavieras(navieraList);
    DBProvider.db.insertPuertos(puertoList);
    DBProvider.db.insertShipper(shipperList);
  }

  static Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}
