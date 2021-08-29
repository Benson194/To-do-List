import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/model/note_model.dart';
import 'package:to_do_list/repository/repository.dart';
import 'package:to_do_list/screens/home_screen/home_screen_event.dart';
import 'package:to_do_list/screens/home_screen/home_screen_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late final Repository _repository;

  HomeBloc(Repository repository) : super(HomeStateInitialized()) {
    _repository = repository;
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    try {
      if (event is GetNoteEvent) {
        yield GetNoteLoading();
        final List<NoteModel> _noteList = await _repository.getNoteList();
        yield GetNoteSuccess(noteList: _noteList);
      } else if (event is UpdateNoteEvent) {
        yield UpdateNoteLoading();
        await _repository.updateCompleted(event.rowId, event.completed ? 1 : 0);
        yield UpdateNoteSuccess(rowId: event.rowId, completed: event.completed);
      } else if (event is UpdateNoteCompletedEvent) {
        yield UpdateNoteCompletedSuccess(rowId: event.index);
      }
    } catch (e) {
      yield GetNoteError();
    }
  }
}
