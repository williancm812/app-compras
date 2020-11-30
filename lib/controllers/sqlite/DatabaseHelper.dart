import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String dbName = "compras.db";
final int dbVersion = 1;

final String tableEmail = "TABLE_EMAIL";
final String emailField = "EMAIL";
final String senhaField = "SENHA";

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal();

  Database _db;

  Future<Database> get database async {
    if (_db != null) {
      return _db;
    } else {
      _db = await _initDatabase();
      return _db;
    }
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    return await openDatabase(path, version: dbVersion, onCreate: (Database db, int newerVersion) async {
      await db.execute("CREATE TABLE IF NOT EXISTS $tableEmail ("
          " $senhaField TEXT,"
          " $emailField TEXT UNIQUE"
          " )");
    });
  }

  Future<List<String>> selectEmail({String email}) async {
    final db = await database;
    String where = email != null ? "WHERE instr($emailField, '$email') > 0" : "";
    String select = "SELECT $emailField as mail FROM $tableEmail $where";

    print(select);
    List list = await db.rawQuery(select);
    List<String> emails = List();
    for (Map e in list) {
      emails.add(e["mail"]);
    }
    return emails;
  }

  Future<void> insertEmail({@required String uid, @required String email}) async {
    try {
      final db = await database;
      Map<String, dynamic> e = {
        senhaField: uid,
        emailField: email,
      };
      List<String> emails = await selectEmail(email: email);
      if (emails.length == 0) {
        await db.insert(tableEmail, e);
      } else
        await db.update(tableEmail, e);
    } catch (e) {
      print(e.toString());
    }
  }
}