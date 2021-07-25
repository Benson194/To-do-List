import 'package:intl/intl.dart';

class DateTimeHelper {
  static final DateFormat formatter = DateFormat('dd MMM yyyy HH:mm:00');
  static final DateFormat formatterToDisplay = DateFormat('dd MMM yyyy');

  static String dateTimeDifference(DateTime startDT, DateTime endDT) {
    Duration timeDifference = endDT.difference(startDT);
    List<String> timeDifferenceInArray = timeDifference.toString().split(':');

    return timeDifferenceInArray[0] +
        " hrs " +
        timeDifferenceInArray[1] +
        " min";
  }
}
