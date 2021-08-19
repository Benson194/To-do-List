abstract class HomeEvent {}

class GetNoteEvent extends HomeEvent {}

class UpdateNoteEvent extends HomeEvent {
  final int rowId;
  final bool completed;
  UpdateNoteEvent({required this.rowId, required this.completed});
}

class UpdateNoteCompletedEvent extends HomeEvent {
  final int index;
  UpdateNoteCompletedEvent({required this.index});
}
