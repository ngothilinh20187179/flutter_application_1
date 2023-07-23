import 'package:flutter_application_1/db/host_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ComfySSHDatabase {
  static const DB_NAME = 'comfySSH.db';
  static const DB_VERSION = 1;
  // static Database _database;
  static Database? _database;

  ComfySSHDatabase._internal();
  static final ComfySSHDatabase instance = ComfySSHDatabase._internal();

  // Database get database => _database
  Database get database => _database ??= init();

  //static const initScripts = [HostTable.CREATE_TABLE_QUERY];
  //static const migrationScripts = [HostTable.CREATE_TABLE_QUERY];

  init() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      onCreate: (db, version) {
        //initScripts.forEach((script) async => await db.execute(script));
        return db.execute(
        'CREATE TABLE host(id INTEGER PRIMARY KEY, content TEXT)',
      );
      },
      // onUpgrade: (db, oldVersion, newVersion) {
      //   migrationScripts.forEach((script) async => await db.execute(script));
      // }, 
      version: DB_VERSION,
    );
  }
}