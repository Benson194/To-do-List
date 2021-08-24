import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_list/helper/date_time_helper.dart';
import 'package:to_do_list/model/note_model.dart';

class NoteModelTest extends Fake implements NoteModel {
  List<NoteModel> generateFake() {
    return [
      NoteModel(
          startDateTime: DateTimeHelper.formatter.parse('12 Jul 2021 12:33:00'),
          endDateTime: DateTimeHelper.formatter.parse('13 Jul 2021 13:34:00'),
          completed: false,
          title: "Unit Test")
    ];
  }
}
