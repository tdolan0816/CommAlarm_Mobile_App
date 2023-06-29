// ignore_for_file: constant_identifier_names


import 'package:commalarm_app/traffic_data_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static const int _version = 1;
  static const String _dbName = "traffic_data.db";

  static const String table_name = "traffic_data";
  static const String column_id = "id";
  static const String column_origin = "origin";
  static const String column_destination = "destination";
  static const String column_duration_in_traffic = "durationInTraffic";


  static const CREATE_TABLE = "CREATE TABLE $table_name ("
      "$column_id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "$column_origin TEXT,"
      "$column_destination TEXT,"
      "$column_duration_in_traffic TEXT)";
  
  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(CREATE_TABLE),
        version: _version);
  }

  static Future<void> insertTrafficData(TrafficDataModel trafficDataModel) async {
    final db = await _getDB();
    await db.insert(
      table_name,
      trafficDataModel.toJSON(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> updateTrafficData(TrafficDataModel trafficDataModel) async {
    final db = await _getDB();
    return await db.update(
      table_name,
      trafficDataModel.toJSON(),
      where: "id = ?",
      whereArgs: [trafficDataModel.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteTrafficData(int id) async {
    final db = await _getDB();
    await db.delete(
      table_name,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<List<TrafficDataModel>> getAllTrafficData() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query(table_name);
    return List.generate(maps.length, (i) {
      return TrafficDataModel.fromJSON(maps[i]);
    }
    );
  }

  static Future<void> deleteAllTrafficData() async {
    final db = await _getDB();
    await db.delete(table_name);
  }

  static Future<void> insertTrafficDataList(List<TrafficDataModel> trafficDataModelList) async {
    final db = await _getDB();
    Batch batch = db.batch();
    trafficDataModelList.forEach((trafficDataModel) {
      batch.insert(table_name, trafficDataModel.toJSON());
    });
    await batch.commit(noResult: true);
    
  }

  static Future<void> updateTrafficDataList(List<TrafficDataModel> trafficDataModelList) async {
    final db = await _getDB();
    Batch batch = db.batch();
    trafficDataModelList.forEach((trafficDataModel) {
      batch.update(table_name, trafficDataModel.toJSON(), where: "id = ?", whereArgs: [trafficDataModel.id]);
    });
    await batch.commit(noResult: true);
  }

  static Future<void> deleteTrafficDataList(List<int> idList) async {
    final db = await _getDB();
    Batch batch = db.batch();
    idList.forEach((id) {
      batch.delete(table_name, where: "id = ?", whereArgs: [id]);
    });
    await batch.commit(noResult: true);
  }

  static Future<void> deleteAllTrafficDataList() async {
    final db = await _getDB();
    Batch batch = db.batch();
    batch.delete(table_name);
    await batch.commit(noResult: true);
  }

  

  static Future<void> insertTrafficDataMap(Map<int, TrafficDataModel> trafficDataModelMap) async {
    final db = await _getDB();
    Batch batch = db.batch();
    trafficDataModelMap.forEach((key, value) {
      batch.insert(table_name, value.toJSON());
    });
    await batch.commit(noResult: true);
  }


  static Future<void> updateTrafficDataMap(Map<int, TrafficDataModel> trafficDataModelMap) async {
    final db = await _getDB();
    Batch batch = db.batch();
    trafficDataModelMap.forEach((key, value) {
      batch.update(table_name, value.toJSON(), where: "id = ?", whereArgs: [value.id]);
    });
    await batch.commit(noResult: true);
  }

  static Future<void> deleteTrafficDataMap(Map<int, TrafficDataModel> trafficDataModelMap) async {
    final db = await _getDB();
    Batch batch = db.batch();
    trafficDataModelMap.forEach((key, value) {
      batch.delete(table_name, where: "id = ?", whereArgs: [value.id]);
    });
    await batch.commit(noResult: true);
  }

  static Future<void> deleteAllTrafficDataMap() async {
    final db = await _getDB();
    Batch batch = db.batch();
    batch.delete(table_name);
    await batch.commit(noResult: true);
  }

}
