import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/model/note_model.dart';
import 'package:path/path.dart';

class LocalDatabase {
  late Database db;
  final String dbName = 'todo_DB';
  final String tableName = 'todo_table';
  final String columnId = 'id';
  final String columnStartDateTime = 'start_date_time';
  final String columnEndDateTime = 'end_date_time';
  final String columnCompleted = 'completed';
  final String columnTitle = 'title';

  static final LocalDatabase _localDatabase = LocalDatabase._internal();

  factory LocalDatabase() {
    return _localDatabase;
  }

  LocalDatabase._internal();

  Future<void> open() async {
    final String databasePath = await getDatabasesPath();
    final String path = join(databasePath, dbName);
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

  Future<List<NoteModel>> getNoteList() async {
    final List<Map<String, Object?>> maps = await db.query(tableName);
    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return NoteModel.fromMap(maps[i]);
      });
    }

    return [];
  }

  Future<void> insert(String startDatetime, String endDateTime, bool completed,
      String title) async {
    await db.insert(tableName,
        NoteModel.toMap(startDatetime, endDateTime, completed, title));
  }

  Future<void> updateCompleted(int _columnId, int _completed) async {
    final int rowUpdated = await db.rawUpdate(
        '''UPDATE $tableName SET $columnCompleted = ? WHERE $columnId = ?''',
        [_completed, _columnId]);
    if (rowUpdated != 1) {
      throw Error();
    }
  }

  Future<void> updateNote(int _rowId, String _startDatetime,
      String _endDateTime, String _title) async {
    final int rowUpdated = await db.rawUpdate(
        '''UPDATE $tableName SET $columnTitle = ?, $columnStartDateTime = ?, $columnEndDateTime = ? WHERE $columnId = ?''',
        [_title, _startDatetime, _endDateTime, _rowId]);
    if (rowUpdated != 1) {
      throw Error();
    }
  }

  Future<void> deleteTable() async {
    await db.delete(tableName);
  }

  Future close() async => db.close();
}
