import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../model/todo.dart';
import '../widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<Todo> _todos;
  final bool _isEnabled;

  TodoList(this._todos, this._isEnabled);

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
                child: TodoItem(_todos[i], _isEnabled),
              );
            })
        : Container();
  }
}
