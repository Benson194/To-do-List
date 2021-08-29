import 'package:to_do_list/model/note_model.dart';
import 'package:to_do_list/services/local_db.dart';

class Repository {
  static final Repository _repository = Repository._internal();

  factory Repository() {
    return _repository;
  }

  Repository._internal();

  Future<void> openDB() async {
    await LocalDatabase().open();
  }

  Future<void> closeDB() async {
    await LocalDatabase().close();
  }

  Future<void> deleteTable() async {
    await LocalDatabase().deleteTable();
  }

  Future<void> createNote(
      {required String startDatetime,
      required String endDateTime,
      required bool completed,
      required String title}) async {
    await LocalDatabase().insert(
        startDatetime: startDatetime,
        endDateTime: endDateTime,
        completed: completed,
        title: title);
  }

  Future<void> updateNote(
      int rowId, String startDatetime, String endDateTime, String title) async {
    await LocalDatabase().updateNote(rowId, startDatetime, endDateTime, title);
  }

  Future<List<NoteModel>> getNoteList() async {
    return LocalDatabase().getNoteList();
  }

  Future<void> updateCompleted(int columnId, int completed) async {
    await LocalDatabase().updateCompleted(columnId, completed);
  }
}
