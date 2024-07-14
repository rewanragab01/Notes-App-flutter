import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/data/models/note_model.dart';
import 'package:note/presentation/view_model/cubit/note_cubit.dart';
import 'package:note/presentation/views/widgets/introbody.dart';
import 'package:note/presentation/views/widgets/notedialog.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () async {
          await HandlingWriting_andSaving_Note(context);
        },
        backgroundColor: Color(0xff252525),
        foregroundColor: Colors.white,
        child: Icon(
          Icons.add,
          size: 35,
        ),
        elevation: 3,
      ),
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          if (state is NoteLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NoteLoaded) {
            return IntroBody(
              notes: state.notes,
            );
          } else if (state is EmptySearchstate) {
            return IntroBody(
              notes: [], // Passing empty list since there are no notes to display
            );
          } else {
            return Center(child: Text('An error occurred'));
          }
        },
      ),
    );
  }

  Future<void> HandlingWriting_andSaving_Note(BuildContext context) async {
    var result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) => NoteDialog(),
    );
    if (result != null &&
        result['note'].isNotEmpty &&
        result['title'].isNotEmpty) {
      context.read<NoteCubit>().addNote(NoteModel(
            title: result['title'],
            content: result['note'],
            timestamp: DateTime.now(),
            color: result['color'],
          ));
    }
  }
}
