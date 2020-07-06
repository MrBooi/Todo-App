import 'package:flutter/material.dart';
import 'package:todo/components/todo/todo_item.dart';

class TodoItemList extends StatelessWidget {
  final ScrollController _controller;
  final List items;

  TodoItemList(this._controller, this.items);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      controller: _controller,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 8, left: 8, top: 4),
          child: TodoItem(
              index: index, id: items[index].id, content: items[index].content),
        );
      },
    );
  }
}
