import 'package:flutter/material.dart';

class EmptyNotes_Body extends StatelessWidget {
  const EmptyNotes_Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Image.asset('assets/images/logo.png'),
        ),
        Text(
          'Create your first note !',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }
}
