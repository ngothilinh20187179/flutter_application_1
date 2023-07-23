import 'package:flutter_application_1/db/comfySSH_database.dart';
import 'package:flutter_application_1/model/host.dart';
import 'package:sqflite/sqflite.dart';

class HostTable {
  static const TABLE_NAME = 'host';
  static const CREATE_TABLE_QUERY = '''
    CREATE TABLE $TABLE_NAME (
      id INTEGER PRIMARY KEY,
      content TEXT
    )
  ''';
  static const DROP_TABLE_QUERY = '''
    DROP TABLE IF EXISTS $TABLE_NAME
  ''';

  Future<int> insertHost(Host host) {
    final Database db = ComfySSHDatabase.instance.database;
    return db.insert(
      TABLE_NAME,
      host.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteHost(Host host) async {
    final Database db = ComfySSHDatabase.instance.database;
    await db.delete(
      TABLE_NAME,
      where: 'id = ?',
      whereArgs: [host.id]
    );
  }

  Future<List<Host>> selectAllHosts() async {
    final Database db = ComfySSHDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('host');
    return List.generate(maps.length, (index) {
      return Host(maps[index]['id'], maps[index]['content']);
    });
  }
}
