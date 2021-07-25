import 'package:to_do_list/helper/date_time_helper.dart';
import 'package:to_do_list/services/local_db.dart';
import 'package:intl/intl.dart';

class NoteModel {
  // int? id;
  DateTime? startDateTime;
  DateTime? endDateTime;
  bool? completed;
  String? title;

  NoteModel({
    // required this.id,
    required this.startDateTime,
    required this.endDateTime,
    required this.completed,
    required this.title,
  });

  static Map<String, Object?> toMap(String _startDatetime, String _endDateTime,
      bool _completed, String _title) {
    var map = <String, Object?>{
      LocalDatabase.columnTitle: _title,
      LocalDatabase.columnStartDateTime: _startDatetime,
      LocalDatabase.columnEndDateTime: _endDateTime,
      LocalDatabase.columnCompleted: _completed == true ? 1 : 0
    };
    return map;
  }

  NoteModel.fromMap(Map<String, Object?> map) {
    // id = map[LocalDatabase.columnId] as int;
    title = map[LocalDatabase.columnTitle] as String;
    completed = map[LocalDatabase.columnCompleted] == 1;
    startDateTime = DateTimeHelper.formatter
        .parse(map[LocalDatabase.columnStartDateTime] as String);
    endDateTime = DateTimeHelper.formatter
        .parse(map[LocalDatabase.columnEndDateTime] as String);
  }
}
