import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final int index;
  final String id;
  final String content;
  final DateTime timestamp;

  TodoItem({this.index, this.id, this.content, this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      child: ListTile(
        title: Text(
          "Task No $index",
          style:
              TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          content,
          style: TextStyle(color: Colors.grey[700]),
        ),
        isThreeLine: true,
      ),
    );
  }
}
