import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final String note;
  final String title;
  final Color color;
  final DateTime timestamp;
  final VoidCallback onDelete; // Add a callback for delete action

  NoteCard({
    required this.title,
    required this.note,
    required this.color,
    required this.timestamp,
    required this.onDelete, // Add the onDelete parameter
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color, // Use the passed color
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.white),
                  onPressed: () => _showDeleteDialog(
                      context), // Show delete confirmation dialog
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              note,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${timestamp.hour}:${timestamp.minute} ${timestamp.day}/${timestamp.month}/${timestamp.year}', // Format timestamp
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this note?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onDelete(); // Call the onDelete callback
              },
            ),
          ],
        );
      },
    );
  }
}
