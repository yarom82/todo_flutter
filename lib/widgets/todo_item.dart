import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/todos_provider.dart';
import '../model/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo _todo;
  final Function _deleteTodoCallback;
  final Function _errorCallback;

  TodoItem(this._todo, this._deleteTodoCallback, this._errorCallback);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(_todo.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        try {
          _deleteTodoCallback(_todo);
        } catch (error) {
          _errorCallback(error);
        }
      },
      child: ListTile(
        key: Key(_todo.id),
        title: Text(_todo.title),
        leading: Checkbox(
          value: _todo.isDone,
          onChanged: (value) => _updateTodoStatus(context, value),
        ),
      ),
    );
  }

  Future _updateTodoStatus(BuildContext context, bool value) async {
    try {
      await Provider.of<TodosProvider>(context).updateTodoStatus(_todo, value);
    } catch (error) {
      _errorCallback(error);
    }
  }
}
