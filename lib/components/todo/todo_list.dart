import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/todo/todo_item.dart';
import 'package:todo/providers/todo.dart';

class TodoItemList extends StatelessWidget {
  final ScrollController _controller;

  TodoItemList(this._controller);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Todos>(context, listen: false).fetchAndSetTodos(),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<Todos>(
                  child: Center(
                    child: const Text('Got no todos, Start adding some!'),
                  ),
                  builder: (ctx, todos, ch) => todos.items.length <= 0
                      ? ch
                      : ListView.builder(
                          itemCount: todos.items.length,
                          controller: _controller,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TodoItem(
                                  index: index + 1,
                                  id: todos.items[index].id,
                                  content: todos.items[index].content),
                            );
                          },
                        ),
                ),
    );
  }
}
