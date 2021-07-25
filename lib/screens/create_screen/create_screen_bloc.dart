import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/helper/date_time_helper.dart';
import 'package:to_do_list/model/NoteModel.dart';
import 'package:to_do_list/repository/repository.dart';
import 'package:to_do_list/screens/create_screen/create_screen_event.dart';
import 'package:to_do_list/screens/create_screen/create_screen_state.dart';

class CreateBloc extends Bloc<CreateEventAbstract, CreateState> {
  late Repository _repository;
  CreateBloc() : super(CreateStateInitialized()) {
    _repository = Repository();
  }

  @override
  Stream<CreateState> mapEventToState(CreateEventAbstract event) async* {
    try {
      if (event is CreateEvent) {
        yield CreateLoading();
        await _repository.createNote(
            event.startDateTime, event.endDateTime, false, event.title);
        yield CreateSuccss();
      }
    } catch (e) {
      yield CreateError();
    }
  }
}
