import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

Map<int, String> scripts = {
  1: '''CREATE TABLE pessoa (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome STRING,
    altura REAL,
    peso INTEGER
  );'''
};

class SQLiteDataBase {
  static Database? db;

  Future<Database> obterDataBase() async {
    if (db == null) {
      return await iniciarBancoDeDados();
    } else {
      return db!;
    }
  }

  Future<Database> iniciarBancoDeDados() async {
    String path = p.join(await getDatabasesPath(), 'pessoa');
    var db = await openDatabase(path, version: scripts.length,
        onCreate: (Database db, int version) async {
      for (var i = 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
      }
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      for (var i = oldVersion; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
      }
    });
    return db;
  }
}
