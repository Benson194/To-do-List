class DateTimeHelper {
  static String dateTimeDifference(DateTime startDT, DateTime endDT) {
    Duration timeDifference = endDT.difference(startDT);
    return timeDifference.inHours.toString() +
        " hrs " +
        timeDifference.inMinutes.toString() +
        " min";
  }
}
