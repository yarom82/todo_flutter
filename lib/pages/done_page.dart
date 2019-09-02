import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../widgets/todo_list.dart';

class DonePage extends StatelessWidget {
  final List<Todo> _todos;

  DonePage(this._todos);

  @override
  Widget build(BuildContext context) {
    final List<Todo> doneTodos = _todos != null ? _todos.where((t) => t.isDone).toList() : null;
    return TodoList(doneTodos, false);
  }
}
