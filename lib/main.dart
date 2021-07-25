import 'package:device_preview/device_preview.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/localization/form_builder_localizations.dart';
import 'package:to_do_list/config/routes.dart';
import 'package:to_do_list/screens/create_screen/create_screen_bloc.dart';
import 'package:to_do_list/screens/home_screen/home_screen.dart';
import 'package:to_do_list/screens/home_screen/home_screen_bloc.dart';
import 'package:to_do_list/theme/color.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    runApp(
      DevicePreview(
        enabled: kDebugMode,
        builder: (context) => MyApp(),
      ),
    );
  } else {
    runApp(MyApp());
  }

  var tree = DebugTree();
  tree.colorizeMap["D"] = ColorizeStyle(
      [AnsiStyle(AnsiSelection.foreground, color: AnsiColor.yellow)]);
  Fimber.plantTree(tree);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) {
            return CreateBloc();
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return HomeBloc();
          },
        ),
      ],
      child: MaterialApp(
          builder: DevicePreview.appBuilder,
          title: appName,
          theme: ThemeData(primaryColor: kPrimaryColor),
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
          routes: routes,
          initialRoute: '/'),
    );
  }
}
