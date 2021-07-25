import 'package:flutter/material.dart';
import 'package:to_do_list/config/constant.dart';
import 'package:to_do_list/screens/create_screen/create_screen.dart';
import 'package:to_do_list/screens/home_screen/home_screen.dart';

final Map<String, WidgetBuilder> routes = {
  createScreenRouteName: (context) => CreateScreen(),
  homeScreenRouteName: (context) => HomeScreen(),
};
