//@dart=2.9
import 'dart:async';
import 'dart:io';

import 'package:app_prueba/models/catalogo.dart';
import 'package:app_prueba/models/consignatario.dart';
import 'package:app_prueba/models/contenedor.dart';
import 'package:app_prueba/models/naviera.dart';
import 'package:app_prueba/models/puerto.dart';
import 'package:app_prueba/models/shipper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB3.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        var batch = db.batch();
        _createTableCatalogosV2(batch);
        _createTableConsignatarioV2(batch);
        _createTableContenedorV2(batch);
        _createTableNavieraV2(batch);
        _createTablePuertoV2(batch);
        _createTableShipperV2(batch);
        await batch.commit();
      },
    );
  }

  void _createTableNavieraV2(Batch batch) {
    batch.execute('''CREATE TABLE Naviera (
    id INTEGER PRIMARY KEY,
    nombre TEXT   
)''');
  }

  void _createTableCatalogosV2(Batch batch) {
    batch.execute('''CREATE TABLE Catalogo (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    version INTEGER,
    fecha TEXT    
)''');
    batch.insert('Catalogo', {
      'id': '1',
      'nombre': 'consignatario',
      'version': 0,
      'fecha': '2000/01/01'
    });
    batch.insert('Catalogo', {
      'id': '2',
      'nombre': 'contenedor',
      'version': 0,
      'fecha': '2000/01/01'
    });
    batch.insert('Catalogo',
        {'id': '3', 'nombre': 'naviera', 'version': 0, 'fecha': '2000/01/01'});
    batch.insert('Catalogo',
        {'id': '4', 'nombre': 'puerto', 'version': 0, 'fecha': '2000/01/01'});
    batch.insert('Catalogo',
        {'id': '5', 'nombre': 'shipper', 'version': 0, 'fecha': '2000/01/01'});
  }

  void _createTablePuertoV2(Batch batch) {
    batch.execute('''CREATE TABLE Puerto (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    codPais TEXT    
)''');
  }

  void _createTableShipperV2(Batch batch) {
    batch.execute('''CREATE TABLE Shipper (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    vendedor INTEGER    
)''');
  }

  void _createTableConsignatarioV2(Batch batch) {
    batch.execute('''CREATE TABLE Consignatario (
    id INTEGER PRIMARY KEY,
    nombre TEXT        
)''');
  }

  void _createTableContenedorV2(Batch batch) {
    batch.execute('''CREATE TABLE Contenedor (
    id INTEGER PRIMARY KEY,
    nombre TEXT        
)''');
  }

  /// Update Naviera table V1 to V2
  void _updateTableNavieraV1toV2(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS Naviera');
    batch.execute('''CREATE TABLE Naviera (
    id INTEGER PRIMARY KEY,
    nombre TEXT   
)''');
  }

  //QUERIES
  getAllNavieras() async {
    final db = await database;
    var res = await db.query("Naviera");
    List<Naviera> list =
        res.isNotEmpty ? res.map((c) => Naviera.fromMap(c)).toList() : [];
    return list;
  }

  getAllConsignatarios() async {
    final db = await database;
    var res = await db.query("Consignatario");
    List<Consignatario> list =
        res.isNotEmpty ? res.map((c) => Consignatario.fromMap(c)).toList() : [];
    return list;
  }

  getAllContenedors() async {
    final db = await database;
    var res = await db.query("Contenedor");
    List<Contenedor> list =
        res.isNotEmpty ? res.map((c) => Contenedor.fromMap(c)).toList() : [];
    return list;
  }

  getAllPuertos() async {
    final db = await database;
    var res = await db.query("Puerto");
    List<Puerto> list =
        res.isNotEmpty ? res.map((c) => Puerto.fromMap(c)).toList() : [];
    return list;
  }

  getAllShippers() async {
    final db = await database;
    var res = await db.query("Shipper");
    List<Shipper> list =
        res.isNotEmpty ? res.map((c) => Shipper.fromMap(c)).toList() : [];
    return list;
  }

  getCatalogos() async {
    final db = await database;
    var res = await db.query("Catalogo");
    List<Catalogo> list =
        res.isNotEmpty ? res.map((c) => Catalogo.fromMap(c)).toList() : [];
    return list;
  }

  //INSERTAR CATALOGOS
  updateCatalogos(String fechaActual) async {
    final db = await database;
    var batch = db.batch();
    for (var i = 1; i < 6; i++) {
      batch.update("Catalogo", {"fecha":fechaActual}, where: 'id = ?', whereArgs: [i]);
    }
    batch.commit();
  }

  insertNavieras(List<Naviera> navieras) async {
    final db = await database;
    var batch = db.batch();
    navieras.forEach((element) {
      batch.insert("Naviera", element.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
    batch.commit();
  }

  insertPuertos(List<Puerto> puertos) async {
    final db = await database;
    var batch = db.batch();

    puertos.forEach((element) {
      batch.insert("Puerto", element.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
    batch.commit();
  }

  insertShipper(List<Shipper> shippers) async {
    final db = await database;
    var batch = db.batch();
    shippers.forEach((element) {
      batch.insert("Shipper", element.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
    batch.commit();
  }

  insertConsignatario(List<Consignatario> consignatario) async {
    final db = await database;
    var batch = db.batch();
    consignatario.forEach((element) {
      batch.insert("Consignatario", element.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
    batch.commit();
  }

  insertContenedor(List<Contenedor> contenedores) async {
    final db = await database;
    var batch = db.batch();
    contenedores.forEach((element) {
      batch.insert("Contenedor", element.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
    batch.commit();
  }
}
