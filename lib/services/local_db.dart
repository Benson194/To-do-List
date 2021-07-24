import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/model/NoteModel.dart';

class LocalDatabase {
  late Database db;
  static final String tableName = 'todo_table';
  static final String columnId = 'id';
  static final String columnStartDateTime = 'start_date_time';
  static final String columnEndDateTime = 'end_date_time';
  static final String columnCompleted = 'completed';
  static final String columnTitle = 'title';

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableName ( 
  $columnId integer primary key autoincrement, 
  $columnTitle text not null,
  $columnCompleted text not null,
  $columnStartDateTime datetime not null,
  $columnCompleted BOOLEAN NOT NULL CHECK (mycolumn IN (0, 1))
''');
    });
  }

  Future<NoteModel> insert(NoteModel noteModel) async {
    noteModel.id = await db.insert(tableName, noteModel.toMap());
    return noteModel;
  }

  Future<NoteModel?> getNote(int id) async {
    List<Map<String, Object?>> maps = await db.query(tableName);
    if (maps.length > 0) {
      return NoteModel.fromMap(maps.first);
    }
    return null;
  }

  // Future<int> update(Todo todo) async {
  //   return await db.update(tableTodo, todo.toMap(),
  //       where: '$columnId = ?', whereArgs: [todo.id]);
  // }

  Future close() async => db.close();
}
