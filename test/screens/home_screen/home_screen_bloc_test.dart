import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_list/model/note_model.dart';
import 'package:to_do_list/repository/repository.dart';
import 'package:to_do_list/screens/create_screen/create_screen_bloc.dart';
import 'package:to_do_list/screens/create_screen/create_screen_event.dart';
import 'package:to_do_list/screens/create_screen/create_screen_state.dart';
import 'package:to_do_list/screens/home_screen/home_screen_bloc.dart';
import 'package:to_do_list/screens/home_screen/home_screen_event.dart';
import 'package:to_do_list/screens/home_screen/home_screen_state.dart';
import '../../model/note_model_test.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class FakeHomeState extends Fake implements HomeState {}

class FakeHomeEvent extends Fake implements HomeEvent {}

class MockCreateBloc extends MockBloc<CreateEventAbstract, CreateState>
    implements CreateBloc {}

class FakeCreateState extends Fake implements CreateState {}

class FakeCreateEvent extends Fake implements CreateEvent {}

class RepositoryMock extends Mock implements Repository {
  @override
  Future<List<NoteModel>> getNoteList() async {
    return NoteModelTest().generateFake();
  }
}

void homeBlocTest() {
  late HomeBloc homeBloc;
  late RepositoryMock repositoryMock;

  group('HomeScreen BLoC -', () {
    blocTest<HomeBloc, HomeState>(
      'Given repository successfully return the note list, the state should return GetNoteSuccess.',
      setUp: () {
        repositoryMock = RepositoryMock();
        homeBloc = HomeBloc(repositoryMock);
      },
      tearDown: () {
        homeBloc.close();
      },
      build: () => homeBloc,
      act: (bloc) => bloc.add(GetNoteEvent()),
      expect: () => [isA<GetNoteLoading>(), isA<GetNoteSuccess>()],
    );
  });
}
