import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../widgets/todo_list.dart';

class TodoPage extends StatelessWidget {
  final List<Todo> _todos;

  TodoPage(this._todos);

  @override
  Widget build(BuildContext context) {
    final List<Todo> todos = _todos != null ? _todos.where((t) => !t.isDone).toList() : null;
    return TodoList(todos, true);
  }
}
