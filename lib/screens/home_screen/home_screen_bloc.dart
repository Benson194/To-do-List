import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/model/NoteModel.dart';
import 'package:to_do_list/repository/repository.dart';
import 'package:to_do_list/screens/home_screen/home_screen_event.dart';
import 'package:to_do_list/screens/home_screen/home_screen_state.dart';

class HomeBloc extends Bloc<HomeEventAbstract, HomeState> {
  late Repository _repository;
  HomeBloc() : super(HomeStateInitialized()) {
    _repository = Repository();
  }

  @override
  Stream<HomeState> mapEventToState(HomeEventAbstract event) async* {
    try {
      if (event is GetNoteEvent) {
        yield GetNoteLoading();
        List<NoteModel>? _noteList = await _repository.getNoteList();
        yield GetNoteSuccess(noteList: _noteList);
      }
    } catch (e) {
      yield GetNoteError();
    }
  }
}
