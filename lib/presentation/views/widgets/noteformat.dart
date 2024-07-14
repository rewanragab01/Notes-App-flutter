import 'package:flutter/material.dart';
import 'package:note/data/models/note_model.dart';
import 'package:note/presentation/views/widgets/editnote.dart';
import 'package:note/presentation/views/widgets/notecard.dart';

class NoteFormat extends StatelessWidget {
  const NoteFormat(
      {super.key,
      required this.notes,
      required this.index,
      required this.onDelete});

  final List<NoteModel> notes;
  final VoidCallback onDelete;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditNote(
                  index: index,
                  title: notes[index].title,
                  content: notes[index].content,
                ),
              ));
        },
        child: NoteCard(
          onDelete: onDelete,
          title: notes[index].title,
          note: notes[index].content,
          color: notes[index].color,
          timestamp: notes[index].timestamp,
        ),
      ),
    );
  }
}
