import 'package:device_preview/device_preview.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/screens/create_screen/create_screen.dart';
import 'package:to_do_list/theme/color.dart';

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
    return MaterialApp(
        title: appName,
        theme: ThemeData(primaryColor: kPrimaryColor),
        debugShowCheckedModeBanner: false,
        home: CreateScreen(),
        initialRoute: '/');
  }
}
