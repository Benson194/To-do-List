import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:to_do_list/config/constant.dart';
import 'package:to_do_list/config/routes.dart';
import 'package:to_do_list/repository/repository.dart';
import 'package:to_do_list/screens/create_screen/create_screen_bloc.dart';
import 'package:to_do_list/screens/home_screen/home_screen.dart';
import 'package:to_do_list/screens/home_screen/home_screen_bloc.dart';
import 'package:to_do_list/theme/color.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await Repository().openDB();
  });
  tearDown(() async {
    await Repository().closeDB();
  });
  testWidgets('Test insert data', (WidgetTester tester) async {
    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) {
            return CreateBloc(Repository());
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return HomeBloc(Repository());
          },
        ),
      ],
      child: MaterialApp(
          title: appName,
          theme: ThemeData(primaryColor: kPrimaryColor),
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
          routes: routes,
          initialRoute: '/'),
    ));
    // ensure the loading dialog will be dismissed
    // by waiting until code in GetNoteSuccess state is executed
    await tester.pumpAndSettle();

    // here we delay for 1 second so that we can
    // see the home screen doesn't have any note
    await Future.delayed(const Duration(seconds: 1), () {});
    expect(find.byKey(const Key("Empty note list")), findsOneWidget);

    // tap create button to go to create screen
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // tap on note title field
    await tester.enterText(find.byKey(const Key("Note Title")), 'Hello!');

    // tap on Start date time DateTimePicker
    await tester.tap(find.byKey(const Key("Start Date time picker")));
    await tester.pumpAndSettle();
    await tester.tap(find.text('10'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // tap on End date time DateTimePicker
    await tester.tap(find.byKey(const Key("End Date time picker")));
    await tester.pumpAndSettle();
    await tester.tap(find.text('13'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // tap on submit button
    await tester.tap(find.byKey(const Key("Submit button")));
    await tester.pumpAndSettle();

    // here we delay for 1 second so that we can
    // see the new note appears in home screen
    await Future.delayed(const Duration(seconds: 1), () {});
    expect(find.byKey(const Key("Empty note list")), findsNothing);
  });
}
