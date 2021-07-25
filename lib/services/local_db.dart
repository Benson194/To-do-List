import 'dart:io';

import 'package:fimber/fimber.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/model/NoteModel.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static late Database db;
  static final String dbName = 'todo_DB';
  static final String tableName = 'todo_table';
  static final String columnId = 'id';
  static final String columnStartDateTime = 'start_date_time';
  static final String columnEndDateTime = 'end_date_time';
  static final String columnCompleted = 'completed';
  static final String columnTitle = 'title';

  static Future open() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, dbName);

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      create table $tableName ( 
        $columnId integer primary key autoincrement, 
        $columnTitle text not null,
        $columnStartDateTime text not null,
        $columnEndDateTime text not null,
        $columnCompleted BOOLEAN NOT NULL CHECK ($columnCompleted IN (0, 1)))
      ''');
    });
  }

  static Future<void> insert(String startDatetime, String endDateTime,
      bool completed, String title) async {
    await db.insert(tableName,
        NoteModel.toMap(startDatetime, endDateTime, completed, title));
  }

  static Future<List<NoteModel>?> getNoteList() async {
    List<Map<String, Object?>> maps = await db.query(tableName);
    if (maps.length > 0) {
      return List.generate(maps.length, (i) {
        return NoteModel.fromMap(maps[i]);
      });
    }

    return null;
  }

  // Future<int> update(Todo todo) async {
  //   return await db.update(tableTodo, todo.toMap(),
  //       where: '$columnId = ?', whereArgs: [todo.id]);
  // }

  static Future close() async => db.close();
}
