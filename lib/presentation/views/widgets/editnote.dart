import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:note/presentation/view_model/cubit/note_cubit.dart';
import 'package:note/presentation/views/widgets/custom_textformfield.dart';
import 'package:note/presentation/views/widgets/customiconbutton.dart';

class EditNote extends StatefulWidget {
  final int index;
  final String title;
  final String content;

  EditNote({
    super.key,
    required this.index,
    required this.title,
    required this.content,
  });

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  final _formKey = GlobalKey<FormState>(); // Add a form key for validation

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    contentController = TextEditingController(text: widget.content);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<NoteCubit>().editNote(widget.index, titleController.text,
          contentController.text, DateTime.now());
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 65),
        child: Form(
          // Wrap the form content with a Form widget
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edit Note',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CustomButton(
                    onPressed: _saveNote,
                    icon: Icons.check,
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'title :',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  CustomTextFormField(
                    hinttext: 'Title',
                    controller: titleController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please Enter The Title ';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'content :',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  CustomTextFormField(
                    hinttext: 'Content',
                    maxLines: 5,
                    controller: contentController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter The content ';
                      }
                      return null;
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
