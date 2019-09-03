import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

import './todo_page.dart';
import '../model/todo.dart';
import '../providers/todos_provider.dart';
import '../widgets/counter.dart';

class TodoHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage>
    with TickerProviderStateMixin {
  TabController _tabController;
  bool isInit = true;
  bool _isLoading = true;
  BuildContext _scaffoldContext;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2, initialIndex: 0);
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      isInit = false;
      Provider.of<TodosProvider>(context).fetchTodos().then((_) =>
        setState(() {
          _isLoading = false;
        })
      );
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todosProvider = Provider.of<TodosProvider>(context);
    final todos = todosProvider.todos;
    final dones = todosProvider.dones;

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
        bottom: TabBar(
          tabs: <Tab>[
            Tab(
              text: 'Todo',
              icon: Icon(Icons.edit),
            ),
            Tab(
              text: 'Done',
              icon: Icon(Icons.done),
            ),
          ],
          controller: _tabController,
        ),
        actions: <Widget>[
          Counter(todos.length),
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        _scaffoldContext = context;
        return TabBarView(
          children: <Widget>[
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : TodoPage(todos, _updateTodoStatus, _deleteTodo),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : TodoPage(dones, _updateTodoStatus, _deleteTodo),
          ],
          controller: _tabController,
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTodo,
      ),
    );
  }

  _updateTodoStatus(Todo todo, bool newStatus) async {
    try {
      await Provider.of<TodosProvider>(context, listen: false).updateTodoStatus(todo, newStatus);
    } catch (error) {
      _showError(error);
    }
  }

  _deleteTodo(Todo todo) async {
    try {
      await Provider.of<TodosProvider>(context, listen: false).removeTodo(todo);
    } catch (error) {
      _showError(error);
    }
  }

  _showError(String error) {
    Scaffold.of(_scaffoldContext).showSnackBar(
      SnackBar(
        content: Text(error),
        duration: new Duration(seconds: 4),
      ),
    );
  }

  _addTodo() async {
    try {
      final dummyResponse = await http.get('https://randomuser.me/api/');
      final extractedData =
          json.decode(dummyResponse.body) as Map<String, dynamic>;

      Map<String, dynamic> name = extractedData['results'][0]['name'];
      final Todo todo =
          Todo(title: '${name['first']} ${name['last']}', isDone: false);

      await Provider.of<TodosProvider>(context, listen: false).addTodo(todo);
    } catch (error) {}
  }
}
