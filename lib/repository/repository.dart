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
    LocalDatabase.insert(startDatetime, endDateTime, completed, title);
  }

  Future<List<NoteModel>?> getNoteList() async {
    return await LocalDatabase.getNoteList();
  }

  Future<void> updateNote(int columnId, int completed) async {
    return await LocalDatabase.update(columnId, completed);
  }
}
