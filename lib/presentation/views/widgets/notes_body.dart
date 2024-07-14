import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/data/models/note_model.dart';
import 'package:note/presentation/view_model/cubit/note_cubit.dart';

import 'package:note/presentation/views/widgets/noteformat.dart';
// Import the NoteCard widget

class Notes_Body extends StatelessWidget {
  const Notes_Body({
    super.key,
    required this.notes,
  });

  final List<NoteModel> notes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final noteKey = notes[index].key as int;
        return NoteFormat(
          onDelete: () =>
              BlocProvider.of<NoteCubit>(context).deleteNoteByKey(noteKey),
          notes: notes,
          index: index,
        );
      },
    );
  }
}
