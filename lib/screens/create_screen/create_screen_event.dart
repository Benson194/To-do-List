abstract class CreateEventAbstract {}

class CreateEvent extends CreateEventAbstract {
  final String title;
  final String startDateTime;
  final String endDateTime;
  CreateEvent(
      {required this.title,
      required this.startDateTime,
      required this.endDateTime});
}

class UpdateEvent extends CreateEventAbstract {
  final int rowId;
  final String title;
  final String startDateTime;
  final String endDateTime;
  UpdateEvent(
      {required this.rowId,
      required this.title,
      required this.startDateTime,
      required this.endDateTime});
}
