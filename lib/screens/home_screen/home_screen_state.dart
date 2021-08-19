import 'package:to_do_list/model/NoteModel.dart';

abstract class HomeState {}

class HomeStateInitialized extends HomeState {}

class GetNoteLoading extends HomeState {}

class GetNoteSuccess extends HomeState {
  final List<NoteModel>? noteList;
  GetNoteSuccess({required this.noteList});
}

class GetNoteError extends HomeState {}

class UpdateNoteLoading extends HomeState {}

class UpdateNoteSuccess extends HomeState {
  final int rowId;
  final bool completed;
  UpdateNoteSuccess({required this.rowId, required this.completed});
}

class UpdateNoteError extends HomeState {}

class UpdateNoteCompletedSuccess extends HomeState {
  final int rowId;
  UpdateNoteCompletedSuccess({required this.rowId});
}
