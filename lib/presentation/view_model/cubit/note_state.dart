part of 'note_cubit.dart';

abstract class NoteState {}

class NoteInitial extends NoteState {}

class NoteLoaded extends NoteState {
  final List<NoteModel> notes;

  NoteLoaded(this.notes);
}

class NoteError extends NoteState {
  final String message;

  NoteError(this.message);
}

class EmptySearchstate extends NoteState {
  final String message;

  EmptySearchstate(this.message);
}

class NoteLoading extends NoteState {}
