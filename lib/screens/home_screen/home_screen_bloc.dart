import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/model/NoteModel.dart';
import 'package:to_do_list/repository/repository.dart';
import 'package:to_do_list/screens/home_screen/home_screen_event.dart';
import 'package:to_do_list/screens/home_screen/home_screen_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late Repository _repository;
  HomeBloc() : super(HomeStateInitialized()) {
    _repository = Repository();
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    try {
      if (event is GetNoteEvent) {
        yield GetNoteLoading();
        List<NoteModel>? _noteList = await _repository.getNoteList();
        yield GetNoteSuccess(noteList: _noteList);
      } else if (event is UpdateNoteEvent) {
        yield UpdateNoteLoading();
        await _repository.updateCompleted(event.rowId, event.completed ? 1 : 0);
        yield UpdateNoteSuccess(rowId: event.rowId, completed: event.completed);
      } else if (event is UpdateNoteCompletedEvent) {
        yield UpdateNoteCompletedSuccess(rowId: event.index);
      }
    } catch (e) {
      Fimber.d("error: " + e.toString());
      yield GetNoteError();
    }
  }
}
