import 'package:to_do_list/services/local_db.dart';

class NoteModel {
  int? id;
  DateTime? startDateTime;
  DateTime? endDateTime;
  bool? completed;
  String? title;

  NoteModel({
    required this.id,
    required this.startDateTime,
    required this.endDateTime,
    required this.completed,
    required this.title,
  });

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      LocalDatabase.columnId: id,
      LocalDatabase.columnTitle: title,
      LocalDatabase.columnStartDateTime: startDateTime,
      LocalDatabase.columnEndDateTime: endDateTime,
      LocalDatabase.columnCompleted: completed == true ? 1 : 0
    };
    if (id != null) {
      map[LocalDatabase.columnId] = id;
    }
    return map;
  }

  NoteModel.fromMap(Map<String, Object?> map) {
    id = map[LocalDatabase.columnId] as int;
    title = map[LocalDatabase.columnTitle] as String;
    completed = map[LocalDatabase.columnCompleted] == 1;
    startDateTime = DateTime.now();
    endDateTime = DateTime.now();
  }
}
