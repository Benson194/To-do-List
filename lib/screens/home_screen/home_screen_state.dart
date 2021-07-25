import 'package:to_do_list/model/NoteModel.dart';

abstract class HomeState {}

class HomeStateInitialized extends HomeState {}

class GetNoteLoading extends HomeState {}

class GetNoteSuccess extends HomeState {
  final List<NoteModel>? noteList;
  GetNoteSuccess({required this.noteList});
}

class GetNoteError extends HomeState {}
