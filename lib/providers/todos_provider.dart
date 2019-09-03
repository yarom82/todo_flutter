import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;

import '../model/todo.dart';

class TodosProvider with ChangeNotifier {
  bool isDirty = false;

  List<Todo> _todos = [];

  List<Todo> get todos {
    return _todos.where((t) => !t.isDone).toList();
  }

  List<Todo> get dones {
    return _todos.where((t) => t.isDone).toList();
  }

  Future<void> updateTodoStatus(Todo todo, bool newStatus) async {
    final oldStatus = todo.isDone;
    _todos[_todos.indexWhere((t) => t.id == todo.id)] =
        Todo(id: todo.id, title: todo.title, isDone: newStatus);
    notifyListeners();

    final String todosFirebaseUrl = 'https://todoapp-6a83a.firebaseio.com/todos/${todo.id}.json';
    try {
      final response = await http.patch(
        todosFirebaseUrl,
        body: json.encode({
          'isDone': newStatus,
        }),
      );
      if (response.statusCode >= 400) {
        _todos[_todos.indexWhere((t) => t.id == todo.id)] =
            Todo(id: todo.id, title: todo.title, isDone: oldStatus);
        notifyListeners();
        throw 'something went wrong.';
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchTodos() async {
    final String todosFirebaseUrl = 'https://todoapp-6a83a.firebaseio.com/todos.json';
    try {
      final response = await http.get(todosFirebaseUrl);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      _todos = extractFetchResult(extractedData);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
  
  Future<void> addTodo(Todo todo) async {
    const String todoAddFirebaseUrl =
        'https://todoapp-6a83a.firebaseio.com/todos.json';
    try {
      final response = await http.post(
        todoAddFirebaseUrl,
        body: json.encode({
          'title': todo.title,
          'isDone': todo.isDone,
        }),
      );

      final newTodo = Todo(
        id: json.decode(response.body)['name'],
        title: todo.title,
        isDone: todo.isDone,
      );

      _todos.add(newTodo);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> removeTodo(Todo todo) async {
    String todoRemoveFirebaseUrl =
        'https://todoapp-6a83a.firebaseio.com/todos/${todo.id}.json';
    try {
      _todos.remove(todo);
      notifyListeners();

      final response = await http.delete(
        todoRemoveFirebaseUrl,
      );

      if (response.statusCode >= 400) {
        _todos.add(todo);
        notifyListeners();
        throw 'something went wrong.';
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  List<Todo> extractFetchResult(Map<String, dynamic> extractedData) {
    final List<Todo> todosResult = [];
    extractedData.forEach((transactionId, transactionData) {
      todosResult.add(Todo(
        id: transactionId,
        title: transactionData['title'],
        isDone: transactionData['isDone'],
      ));
    });
    return todosResult;
  }
}
