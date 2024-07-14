import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/data/models/note_model.dart';
import 'package:note/presentation/view_model/cubit/note_cubit.dart';
import 'package:note/presentation/views/widgets/customiconbutton.dart';
import 'package:note/presentation/views/widgets/editnote.dart';
import 'package:note/presentation/views/widgets/emptynotes_body.dart';
import 'package:note/presentation/views/widgets/notes_body.dart';

class IntroBody extends StatefulWidget {
  const IntroBody({
    super.key,
    required this.notes,
  });

  final List<NoteModel> notes;

  @override
  _IntroBodyState createState() => _IntroBodyState();
}

class _IntroBodyState extends State<IntroBody> {
  bool _showAllNotesIcon = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 65),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 43,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  CustomButton(
                    onPressed: () => _showSearchDialog(context),
                    icon: Icons.search,
                  ),
                  SizedBox(width: 5),
                  if (_showAllNotesIcon)
                    CustomButton(
                      onPressed: () {
                        context.read<NoteCubit>().loadNotes(); // Load all notes
                        setState(() {
                          _showAllNotesIcon =
                              false; // Hide the icon after loading all notes
                        });
                      },
                      icon: Icons.book_outlined, // Icon to show all notes
                    ),
                ],
              )
            ],
          ),
          BlocBuilder<NoteCubit, NoteState>(
            builder: (context, state) {
              if (state is EmptySearchstate) {
                return Expanded(
                  child: Center(
                    child: Text(
                      state.message,
                      style: TextStyle(
                        color: Colors.white.withOpacity(.5),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: widget.notes.isEmpty
                      ? const EmptyNotes_Body()
                      : Notes_Body(notes: widget.notes),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    final searchController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Search Notes'),
          content: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Enter search query',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final query = searchController.text;
                context.read<NoteCubit>().searchNotes(query);
                Navigator.pop(context);
                setState(() {
                  _showAllNotesIcon = true; // Show the icon after searching
                });
              },
              child: Text('Search'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
