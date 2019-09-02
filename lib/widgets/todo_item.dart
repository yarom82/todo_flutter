import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/todos_provider.dart';
import '../model/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo _todo;
  final bool _isEnabled;

  TodoItem(this._todo, this._isEnabled);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(_todo.id),
      title: Text(_todo.title),
      leading: Checkbox(
        value: _todo.isDone,
        onChanged: _isEnabled ? (value) => _updateTodoStatus(context, value) : null,
      ),
    );
  }

  Future _updateTodoStatus(BuildContext context, bool value) async {
    await Provider.of<TodosProvider>(context).updateTodoStatus(_todo, value);
  }
}
