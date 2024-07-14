import 'package:flutter/material.dart';
import 'package:note/presentation/views/widgets/custom_textformfield.dart';

class NoteDialog extends StatefulWidget {
  @override
  _NoteDialogState createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  final TextEditingController _Contentcontroller = TextEditingController();
  final TextEditingController _Titlecontroller = TextEditingController();
  Color _selectedColor = Colors.blue; // Default color
  GlobalKey<FormState> formkey = GlobalKey();
  String? content;
  String? title;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Write a Note'),
      content: Form(
        autovalidateMode: autovalidateMode,
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                hinttext: 'Enter title here ',
                controller: _Titlecontroller,
                onSaved: (value) {
                  title = value;
                },
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please Enter The Title ';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 8,
              ),
              CustomTextFormField(
                hinttext: 'Enter your note here',
                maxLines: 5,
                controller: _Contentcontroller,
                onSaved: (value) {
                  content = value;
                },
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please Enter The Note ';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10),
              Text(
                'Pick a Color',
              ),
              SizedBox(height: 10),
              Container(
                height: 50, // Set the height to make it scrollable
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: Colors.primaries.map((color) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = color;
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: color,
                            border: Border.all(
                              color: _selectedColor == color
                                  ? Colors.black
                                  : Colors.transparent,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (formkey.currentState!.validate()) {
              formkey.currentState!.save();

              Navigator.pop(context, {
                'note': _Contentcontroller.text,
                'color': _selectedColor,
                'title': _Titlecontroller.text
              });
            } else {
              autovalidateMode = AutovalidateMode.always;
              setState(() {});
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
