import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/todo.dart';

class CreateTodoPage extends StatefulWidget {
  static final String routeName = '/create-todo';

  @override
  _CreateTodoPageState createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  TextEditingController _contentController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  String _id = '';
  bool isInit = true;

  var editedData;

  @override
  void didChangeDependencies() {
    fetch();

    super.didChangeDependencies();
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

  void fetch() {
    if (isInit) {
      var todoId = ModalRoute.of(context).settings.arguments as String;
      setState(() {
        _id = todoId;
      });
    }
    if (_id == null) {
      print('isEmpty');
      return;
    } else {
      var result = Provider.of<Todos>(context, listen: false).findById(_id);

      editedData = {
        'id': result.id,
        'content': result.content,
        'timestamp': result.timeStamp
      };

      _contentController.text = editedData['content'];
    }
  }

  void _save() {
    if (_contentController.text.isEmpty) {
      showInSnackBar('Opps content cant be empty!');
      return;
    }
    if (_id == null) {
      Provider.of<Todos>(context, listen: false).addTodo(
        _contentController.text,
      );
    } else {
      Provider.of<Todos>(context, listen: false).update(_id, editedData);
    }

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
        _id == null ? 'Create Todos' : 'Update Todos',
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
        onChanged: (value) {
          setState(() {
            editedData['content'] = value;
          });
        },
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
              _id == null ? 'Save' : 'Edit',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}
