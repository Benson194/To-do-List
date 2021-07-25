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
