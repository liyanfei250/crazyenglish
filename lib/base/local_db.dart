import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class LocalDb {
  Database? _database;

  LocalDb._();

  static LocalDb instance = LocalDb._();

  Future<void> initDb({String name = "flutter.db"}) async {
    if (_database != null) return;
    String databasesPath = await getDatabasesPath();
    String dbPath = path.join(databasesPath, name);

    _database = await openDatabase(dbPath);


    print('初始化数据库....');
  }

  Future<void> closeDb() async {
    await _database!.close();
    _database = null;
  }
}
