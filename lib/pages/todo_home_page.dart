import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

import './done_page.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2, initialIndex: 0);
    // Provider.of<TodosProvider>(context).fetchTodos();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      isInit = false;
      Provider.of<TodosProvider>(context).fetchTodos();
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
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
          Counter(todos != null ? todos.length : 0),
        ],
      ),
      body: TabBarView(
        children: <Widget>[
          TodoPage(todos),
          DonePage(todos),
        ],
        controller: _tabController,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTodo,
      ),
    );
  }

  _addTodo() async {
    try {
      final dummyResponse = await http.get('https://randomuser.me/api/');
      final extractedData = json.decode(dummyResponse.body) as Map<String, dynamic>;
      
      Map<String, dynamic> name = extractedData['results'][0]['name'];
      final Todo todo = Todo(title: '${name['first']} ${name['last']}', isDone: false);

      await Provider.of<TodosProvider>(context, listen: false).addTodo(todo);
    } catch (error) {

    }
  }
}
