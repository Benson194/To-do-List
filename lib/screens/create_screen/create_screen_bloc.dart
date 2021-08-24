import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/repository/repository.dart';
import 'package:to_do_list/screens/create_screen/create_screen_event.dart';
import 'package:to_do_list/screens/create_screen/create_screen_state.dart';

class CreateBloc extends Bloc<CreateEventAbstract, CreateState> {
  late final Repository _repository;
  CreateBloc(Repository repository) : super(CreateStateInitialized()) {
    _repository = repository;
  }

  @override
  Stream<CreateState> mapEventToState(CreateEventAbstract event) async* {
    try {
      if (event is CreateEvent) {
        yield CreateLoading();
        await _repository.createNote(
            event.startDateTime, event.endDateTime, false, event.title);
        yield CreateSuccss();
      } else if (event is UpdateEvent) {
        yield UpdateLoading();
        await _repository.updateNote(
            event.rowId, event.startDateTime, event.endDateTime, event.title);
        yield UpdateSuccss();
      }
    } catch (e) {
      yield CreateError();
    }
  }
}
