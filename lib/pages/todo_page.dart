import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../widgets/todo_list.dart';

class TodoPage extends StatelessWidget {
  final List<Todo> _todos;
  final Function _updateTodoStatus;
  final Function _deleteTodo;

  TodoPage(this._todos, this._updateTodoStatus, this._deleteTodo);

  @override
  Widget build(BuildContext context) {
    return TodoList(_todos, _updateTodoStatus, _deleteTodo);
  }
}
