import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../widgets/todo_list.dart';

class TodoPage extends StatelessWidget {
  final List<Todo> _todos;
  final Function _deleteTodoCallback;
  final Function _errorCallback;

  TodoPage(this._todos, this._deleteTodoCallback, this._errorCallback);

  @override
  Widget build(BuildContext context) {
    return TodoList(_todos, _deleteTodoCallback, _errorCallback);
  }
}
