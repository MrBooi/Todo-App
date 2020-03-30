import 'package:flutter/foundation.dart';

class TodoModel {
  final String id;
  final String content;
  final String timeStamp;

  TodoModel({
    @required this.id,
    @required this.content,
    @required this.timeStamp,
  });
}
