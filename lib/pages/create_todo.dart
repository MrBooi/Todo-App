import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/todo.dart';

class CreateTodoPage extends StatefulWidget {
  static final String routeName = '/create-todo';

  @override
  _CreateTodoPageState createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  TextEditingController _contentController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _contentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _contentController?.dispose();
    super.dispose();
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        elevation: 2,
        backgroundColor: _theme.primaryColor,
        content: new Text(value),
      ),
    );
  }

  void _save() {
    if (_contentController.text.isEmpty) {
      showInSnackBar('Opps content cant be empty!');
      return;
    }
    Provider.of<Todos>(context, listen: false).addTodo(
      _contentController.text,
    );
    Navigator.of(context).pop();
  }

  ThemeData _theme;
  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text(
        'Create Todos',
        style: TextStyle(
          color: _theme.accentColor,
        ),
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            buildTextField(),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget paddable(child) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }

  Widget buildTextField() {
    return Card(
      margin: const EdgeInsets.only(right: 20, left: 20, bottom: 15),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextField(
        maxLines: 4,
        controller: _contentController,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
          hintText: 'Create a todo...',
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: RaisedButton(
            color: Colors.pink,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            onPressed: _save,
            child: Text(
              'Save',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}
