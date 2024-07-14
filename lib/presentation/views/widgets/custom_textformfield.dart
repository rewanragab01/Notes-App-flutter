import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final String? hinttext;
  int? maxLines;

  CustomTextFormField({
    this.maxLines,
    this.controller,
    this.onSaved,
    this.validator,
    this.hinttext,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      controller: controller,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        fillColor: Colors.white70,
        filled: true,
        hintText: hinttext,
        hintStyle: TextStyle(),
        border: OutlineInputBorder(),
      ),
    );
  }
}
