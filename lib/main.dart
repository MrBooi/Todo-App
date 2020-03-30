import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/todo.dart';

import 'app.dart';

void main() => runApp(
      ChangeNotifierProvider.value(
        value: Todos(),
        child: TodoAPP(),
      ),
    );
