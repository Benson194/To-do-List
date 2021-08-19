import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_list/helper/date_time_helper.dart';
import 'package:to_do_list/main.dart';
import 'package:to_do_list/model/NoteModel.dart';
import 'package:to_do_list/repository/repository.dart';
import 'package:to_do_list/screens/create_screen/create_screen_bloc.dart';
import 'package:to_do_list/screens/home_screen/home_screen_bloc.dart';
import 'package:to_do_list/screens/home_screen/home_screen_event.dart';
import 'package:to_do_list/screens/home_screen/home_screen_state.dart';
import 'package:to_do_list/screens/home_screen/home_screen.dart';

class HomeBlocMock extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class HomeStateFake extends Fake implements HomeState {}

class HomeEventFake extends Fake implements HomeEvent {}

void HomeScreenTest() {
  late HomeBlocMock homeBlocMock;
  late List<NoteModel> noteModelList;

  setUp(() {
    registerFallbackValue<HomeState>(HomeStateFake());
    registerFallbackValue<HomeEvent>(HomeEventFake());
    homeBlocMock = HomeBlocMock();
    noteModelList = [
      NoteModel(
          startDateTime: DateTimeHelper.formatter.parse('12 Jul 2021 12:33:00'),
          endDateTime: DateTimeHelper.formatter.parse('13 Jul 2021 13:34:00'),
          completed: false,
          title: "Unit Test")
    ];
  });
  tearDown(() {
    homeBlocMock.close();
  });
  group('Mock HomeScreen\n', () {
    testWidgets(
        '1. Should show the note title, start date and end date after note is added',
        (WidgetTester tester) async {
      whenListen(
          homeBlocMock,
          Stream.fromIterable(
              [GetNoteLoading(), GetNoteSuccess(noteList: noteModelList)]));
      await tester.pumpWidget(
        MultiBlocProvider(
            providers: [
              BlocProvider<CreateBloc>.value(
                value: CreateBloc(),
              ),
              BlocProvider<HomeBloc>.value(
                value: HomeBloc(),
              ),
            ],
            child: MaterialApp(
              home: NoteList(
                homeBloc: HomeBloc(),
                noteModelList: noteModelList,
              ),
            )),
      );
      await tester.pump(Duration.zero);
      expect(find.text('Unit Test'), findsOneWidget);
      expect(
          find.text(DateTimeHelper.formatterToDisplay
              .format(DateTimeHelper.formatter.parse('12 Jul 2021 12:33:00'))),
          findsOneWidget);
      expect(
          find.text(DateTimeHelper.formatterToDisplay
              .format(DateTimeHelper.formatter.parse('13 Jul 2021 12:34:00'))),
          findsOneWidget);
    });

    // this is how u can test the bloc in unit test
    // blocTest<HomeBloc, HomeState>(
    //   'emits [] when nothing is added',
    //   build: () => homeBloc,
    //   act: (homeBloc) => homeBloc.add(GetNoteEvent()),
    //   expect: () => [isA<GetNoteLoading>(), isA<GetNoteError>()],
    // );
  });
}
