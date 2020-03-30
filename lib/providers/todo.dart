import 'package:flutter/foundation.dart';
import 'package:todo/helpers/db_helper.dart';
import 'package:todo/models/todo_model.dart';

class Todos with ChangeNotifier {
  List<TodoModel> _items = [];

  List<TodoModel> get items {
    return [..._items];
  }

  TodoModel findById(String id) {
    return _items.firstWhere((todo) => todo.id == id);
  }

  void addTodo(String content) async {
    final newTodo = TodoModel(
      id: DateTime.now().toString(),
      content: content,
      timeStamp: DateTime.now().toIso8601String(),
    );

    _items.add(newTodo);
    notifyListeners();
    DBHelper.insert('user_todos', {
      'id': newTodo.id,
      'content': newTodo.content,
      'timestamp': newTodo.timeStamp
    });
  }

  Future<void> fetchAndSetTodos() async {
    final dataList = await DBHelper.getData('user_todos');
    _items = dataList
        .map(
          (item) => TodoModel(
            id: item['id'],
            content: item['content'],
            timeStamp: item['timestamp'],
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> removeTodo(String id) async {
    _items.removeWhere((todo) => todo.id == id);
    notifyListeners();
    DBHelper.delete('user_todos', id);
  }
}
