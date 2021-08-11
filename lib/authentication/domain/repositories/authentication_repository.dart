//@dart=2.9
import 'dart:async';
import 'dart:convert';
import 'package:app_prueba/models/api_response/api_catalogos.dart';
import 'package:app_prueba/models/catalogo.dart';
import 'package:app_prueba/services/database.dart';
import 'package:app_prueba/services/requests.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../util.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated, failed }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    @required String username,
    @required String password,
  }) async {
    assert(username != null);
    assert(password != null);
    String body = "";
    final prefs = await SharedPreferences.getInstance();
    try {
      body = await NetworkHelper.attemptLogIn(username, password);
      if (body != "") {
        Map<String, dynamic> user = jsonDecode(body);
        prefs.setString("token", user['token']);
        //Map<String, dynamic> decodedJwt = Utils.parseJwt(user["token"]);
        
        String catalogos = "";
        List<Catalogo> cat = await DBProvider.db.getCatalogos();

        Map<String, dynamic> reqBody = {
          "consignatario": {
            "version": cat.where((element) => element.id == 1).first.version,
            "fecha": cat.where((element) => element.id == 1).first.fecha
          },
          "contenedor": {
            "version": cat.where((element) => element.id == 2).first.version,
            "fecha": cat.where((element) => element.id == 2).first.fecha
          },
          "naviera": {
            "version": cat.where((element) => element.id == 3).first.version,
            "fecha": cat.where((element) => element.id == 3).first.fecha
          },
          "puerto": {
            "version": cat.where((element) => element.id == 4).first.version,
            "fecha": cat.where((element) => element.id == 4).first.fecha
          },
          "shipper": {
            "version": cat.where((element) => element.id == 5).first.version,
            "fecha": cat.where((element) => element.id == 5).first.fecha
          },
        };
        catalogos = await NetworkHelper.obtenerCatalogos(reqBody);
        Map<String, dynamic> catalogosApi = jsonDecode(catalogos);
        ApiResponse api = ApiResponse.fromJson(catalogosApi);
        Utils.actualizarCatalogos(api);
        
        _controller.add(AuthenticationStatus.authenticated);
        
      }
    } on Exception {
      _controller.add(AuthenticationStatus.failed);
    }
  }

  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void failed() {
    _controller.add(AuthenticationStatus.unknown);
  }

  void dispose() => _controller.close();

  
}
