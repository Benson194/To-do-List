import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_list/helper/date_time_helper.dart';

void dateTimeHelperTest() {
  test(
      'DateTimeHelper - Given start date time and end date time, the correct time difference should be returned.',
      () {
    final String expectedResult = DateTimeHelper.dateTimeDifference(
        DateTimeHelper.formatter.parse('12 Jul 2021 12:33:00'),
        DateTimeHelper.formatter.parse('13 Jul 2021 13:34:00'));

    const String actualResult = "25 hrs 01 min";
    expect(actualResult, expectedResult);
  });
}
