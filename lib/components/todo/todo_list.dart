import 'package:flutter/material.dart';
import 'package:todo/components/todo/todo_item.dart';

class TodoItemList extends StatelessWidget {
  final ScrollController _controller;

  TodoItemList(this._controller);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 25,
      controller: _controller,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TodoItem(
            index: index + 1,
            content: "Take bin out"
          ),
        );
      },
    );
  }
}
