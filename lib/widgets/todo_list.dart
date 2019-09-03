import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../model/todo.dart';
import '../widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<Todo> _todos;
  final Function _updateTodoStatus;
  final Function _deleteTodo;

  TodoList(this._todos, this._updateTodoStatus, this._deleteTodo);

  @override
  Widget build(BuildContext context) {
    return _todos != null && _todos.length > 0
        ? ListView.separated(
            separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
            itemCount: _todos.length,
            itemBuilder: (ctx, i) {
              return ChangeNotifierProvider.value(
                value: _todos[i],
                child: TodoItem(_todos[i], _updateTodoStatus, _deleteTodo),
              );
            })
        : Container();
  }
}
