import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_list/helper/date_time_helper.dart';
import 'package:to_do_list/screens/create_screen/create_screen_bloc.dart';
import 'package:to_do_list/screens/create_screen/create_screen_event.dart';
import 'package:to_do_list/screens/create_screen/create_screen_state.dart';
import 'package:to_do_list/screens/home_screen/home_screen_bloc.dart';
import 'package:to_do_list/screens/home_screen/home_screen_event.dart';
import 'package:to_do_list/screens/home_screen/home_screen_state.dart';
import 'package:to_do_list/screens/home_screen/home_screen.dart';

import '../../model/note_model_test.dart';
import 'home_screen_bloc_test.dart';

void homeScreenTest() {
  late MockHomeBloc mockHomeBloc;
  late MockCreateBloc mockCreateBloc;
  late Widget homeScreen;
  late Directory currentDirectory;

  setUp(() {
    registerFallbackValue<HomeState>(FakeHomeState());
    registerFallbackValue<HomeEvent>(FakeHomeEvent());
    registerFallbackValue<CreateEvent>(FakeCreateEvent());
    registerFallbackValue<CreateState>(FakeCreateState());
    mockHomeBloc = MockHomeBloc();
    mockCreateBloc = MockCreateBloc();
    homeScreen = MultiBlocProvider(
        providers: [
          BlocProvider<CreateBloc>.value(
            value: mockCreateBloc,
          ),
          BlocProvider<HomeBloc>.value(
            value: mockHomeBloc,
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: NoteList(
            homeBloc: mockHomeBloc,
            noteModelList: NoteModelTest().generateFake(),
          ),
        ));
    currentDirectory = Directory.current;
  });
  tearDown(() {
    mockHomeBloc.close();
  });
  group('HomeScreen -', () {
    testWidgets(
        '1. Given the empty note list, there should be text displayed instead of the empty note list.',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NoteList(
          homeBloc: mockHomeBloc,
          noteModelList: const [],
        ),
      ));
      expect(find.byKey(const Key("Empty note list")), findsOneWidget);
    });
    testWidgets(
        '2. Given the mocked note list, the note list should show the same title, start date, and end date.',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NoteList(
          homeBloc: mockHomeBloc,
          noteModelList: NoteModelTest().generateFake(),
        ),
      ));
      expect(find.byKey(const Key("Empty note list")), findsNothing);
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

    testWidgets('3. Golden test', (WidgetTester tester) async {
      await tester.pumpWidget(homeScreen);
      await expectLater(
          find.byWidget(homeScreen),
          matchesGoldenFile(
              '${currentDirectory.path}/test/screens/home_screen/home_screen_test.png'));
    });
  });
}
