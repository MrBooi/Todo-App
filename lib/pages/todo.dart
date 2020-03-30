import 'package:flutter/material.dart';
import 'package:todo/components/todo/todo_list.dart';

// import Screens
import '../pages/create_todo.dart';

class TodoPage extends StatefulWidget {
  static final String routeName = '/todo';

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Scaffold(
      backgroundColor: _theme.primaryColor,
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Stack(
      children: <Widget>[
        buildHeader(),
        buildDraggableSheet(),
      ],
    );
  }

  Widget buildHeader() {
    return Positioned(
      top: 80,
      left: 20,
      child: Text(
        'Todos',
        style: TextStyle(
          color: _theme.accentColor,
          fontSize: 40,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget buildDraggableSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.1,
      minChildSize: 0.1,
      maxChildSize: 0.8,
      builder: (BuildContext context, _controller) {
        return Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: _theme.accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: TodoItemList(_controller),
            ),
            buildAddBtn()
          ],
        );
      },
    );
  }

  Widget buildAddBtn() {
    return Positioned(
      right: 30,
      top: -30,
      child: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Icon(
          Icons.add,
          color: _theme.accentColor,
        ),
        onPressed: () {
          Navigator.pushNamed(context, CreateTodoPage.routeName);
        },
      ),
    );
  }
}
