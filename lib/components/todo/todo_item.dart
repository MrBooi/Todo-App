import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/pages/create_todo.dart';
import 'package:todo/providers/todo.dart';

class TodoItem extends StatelessWidget {
  final int index;
  final String id;
  final String content;
  final DateTime timestamp;

  TodoItem({this.index, this.id, this.content, this.timestamp});

  void remove(BuildContext context, String id) {
    Provider.of<Todos>(context, listen: false).removeTodo(id);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Task No ${index + 1} ",
        style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        content,
        style: TextStyle(color: Colors.grey[700]),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.pink,
            ),
            onPressed: () {
              Navigator.pushNamed(context, CreateTodoPage.routeName,
                  arguments: id);
              // remove(context, id);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.pink,
            ),
            onPressed: () {
              remove(context, id);
            },
          )
        ],
      ),
      isThreeLine: true,
    );
  }
}
