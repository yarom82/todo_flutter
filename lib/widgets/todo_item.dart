import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo _todo;
  final Function _updateTodoStatus;
  final Function _deleteTodo;

  TodoItem(this._todo, this._updateTodoStatus, this._deleteTodo);

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
          _deleteTodo(_todo);
        } catch (error) {
          throw error;
        }
      },
      child: ListTile(
        key: Key(_todo.id),
        title: Text(_todo.title),
        leading: Checkbox(
          value: _todo.isDone,
          onChanged: (value) {
            try {
              _updateTodoStatus(_todo, value);
            } catch (error) {
              throw error;
            }
          },
        ),
      ),
    );
  }
}
