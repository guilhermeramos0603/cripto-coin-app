import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class Db {
  Db._();

  static final Db instance = Db._();

  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), "crypt.db"),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, version) async {
    await db.execute(_account);
    await db.execute(_portfolio);
    await db.execute(_history);
    await db.insert("account", {"balance": 0});
  }

  String get _account => ''' 
  CREATE TABLE account (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    balance REAL 
  );
  ''';

  String get _portfolio => ''' 
  CREATE TABLE portfolio (
    acronym TEXT PRIMARY KEY,
    coin TEXT,
    quantity TEXT
  );
  ''';

  String get _history => ''' 
  CREATE TABLE history (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    createdAt INT PRIMARY KEY,
    operation_type TEXT,
    coin TEXT
    acronym TEXT
    value REAL
    quantity REAL
  );
  ''';
}
