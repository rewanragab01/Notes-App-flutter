import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:note/data/models/note_model.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  var notesBox = Hive.box<NoteModel>('notes_box');

  NoteCubit() : super(NoteInitial()) {
    loadNotes();
  }

  void loadNotes() {
    final notes = notesBox.values.toList();
    emit(NoteLoaded(_sortNotes(notes)));
  }

  void addNote(NoteModel note) {
    notesBox.add(note);
    loadNotes(); // Re-fetch notes and update state
  }

  void editNote(int index, String title, String content, DateTime timestamp) {
    final note = notesBox.getAt(index);
    if (note != null) {
      final updatedNote = NoteModel(
        timestamp: timestamp,
        title: title,
        content: content,
        color: note.color, // Preserve the existing color
      );
      notesBox.putAt(index, updatedNote);
      loadNotes(); // Re-fetch notes and update state
    }
  }

  void deleteNoteByKey(int key) {
    notesBox.delete(key);
    loadNotes(); // Re-fetch notes and update state
  }

  void searchNotes(String query) {
    emit(NoteLoading()); // Indicate that the search is in progress
    final searchnotes = notesBox.values
        .where((note) =>
            note.title.toLowerCase().contains(query.toLowerCase()) ||
            note.content.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (searchnotes.isEmpty) {
      emit(EmptySearchstate('No notes match your search, try again!'));
    } else {
      emit(NoteLoaded(_sortNotes(searchnotes)));
    }
  }

  List<NoteModel> _sortNotes(List<NoteModel> notes) {
    notes.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return notes;
  }
}
