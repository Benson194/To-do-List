import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_list/helper/date_time_helper.dart';

void DateTimeHelperTest() {
  test(
      'should return the time difference given start date time and end date time',
      () {
    String expectedResult = DateTimeHelper.dateTimeDifference(
        DateTimeHelper.formatter.parse('12 Jul 2021 12:33:00'),
        DateTimeHelper.formatter.parse('13 Jul 2021 13:34:00'));

    String actualResult = "25 hrs 01 min";
    expect(actualResult, expectedResult);
  });
}
