abstract class HomeEventAbstract {}

class GetNoteEvent extends HomeEventAbstract {}

class UpdateNoteEvent extends HomeEventAbstract {
  final int rowId;
  final bool completed;
  UpdateNoteEvent({required this.rowId, required this.completed});
}
