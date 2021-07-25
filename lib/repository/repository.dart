import 'package:to_do_list/model/NoteModel.dart';
import 'package:to_do_list/services/local_db.dart';

class Repository {
  static final Repository _repository = Repository._internal();

  factory Repository() {
    return _repository;
  }

  Repository._internal();

  Future<void> openDB() async {
    await LocalDatabase.open();
  }

  Future<void> closeDB() async {
    await LocalDatabase.close();
  }

  Future<void> createNote(String startDatetime, String endDateTime,
      bool completed, String title) async {
    await LocalDatabase.insert(startDatetime, endDateTime, completed, title);
  }

  Future<void> updateNote(
      int rowId, String startDatetime, String endDateTime, String title) async {
    await LocalDatabase.updateNote(rowId, startDatetime, endDateTime, title);
  }

  Future<List<NoteModel>?> getNoteList() async {
    return await LocalDatabase.getNoteList();
  }

  Future<void> updateCompleted(int columnId, int completed) async {
    await LocalDatabase.updateCompleted(columnId, completed);
  }
}
