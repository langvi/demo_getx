import 'dart:async';
import 'dart:io';

import 'package:demo_getx/model/notify.dart';
import 'package:demo_getx/model/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

const keyIdProduct = 'key_product';
const keyIdNotify = 'key_notify';

class MyDatabase {
  static final _databaseName = "MyDb.db";
  static final _databaseVersion = 1;

  static final notifyTable = 'notify';
  static final productTable = 'product';

  MyDatabase._privateConstructor();
  static final MyDatabase instance = MyDatabase._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    print('Init database....');
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    print('Oncreate');
    await db.execute('''
          CREATE TABLE $notifyTable (
            ${Notify.columnId} INTEGER PRIMARY KEY,
            ${Notify.columnTitle} TEXT,
            ${Notify.columnStatus} INTEGER
          )
          ''');
    await db.execute('''
          CREATE TABLE $productTable (
            ${Product.columnId} INTEGER PRIMARY KEY,
            ${Product.columnName} TEXT,
            ${Product.columnAmount} INTEGER,
            ${Product.columnType} INTEGER
          )
          ''');
  }

  Future<void> closeDatabase() async {
    await _database!.close();
  }

  // Future<List<Map<String, dynamic>>> queryRecordByPage(
  //     int pageIndex, int pageSize) async {
  //   print(
  //       'start get data with pageIndex = $pageIndex , pageSize = $pageSize....');
  //   return await _database!.rawQuery(
  //       'select $columnId, $columnTitle, $columnStatus, $columnTitle from $currentTable limit $pageSize offset $pageIndex');
  // }

  // Future<List<Map<String, dynamic>>> queryByString(String keyword) async {
  //   String str = '%$keyword%';
  //   return await _database!.rawQuery(
  //       'select * from $currentTable where $columnTitle like "$str" limit 10');
  // }
}
