import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:to_do_list/main.dart';
import 'package:to_do_list/screens/home_screen/home_screen_bloc.dart';
import 'package:to_do_list/screens/home_screen/home_screen_event.dart';
import 'package:to_do_list/screens/home_screen/home_screen_state.dart';

import 'helper/date_time_helper_test.dart';
import 'screens/home_screen/home_screen_test.dart';

void main() {
  DateTimeHelperTest();
  HomeScreenTest();
}
