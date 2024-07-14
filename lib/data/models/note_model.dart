import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  final String content;

  @HiveField(1)
  final DateTime timestamp;

  @HiveField(2)
  final Color color;

  @HiveField(3)
  final String title;

  NoteModel({
    required this.title,
    required this.content,
    required this.timestamp,
    required this.color,
  });
}
