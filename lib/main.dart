import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todos_provider.dart';

import './pages/todo_home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: TodosProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 44, 62, 80),
          accentColor: Color.fromARGB(255, 60, 198, 171),
          textTheme: TextTheme( 
            title: TextStyle( fontSize: 16 , color: Colors.white),
          )
        ),
        home: TodoHomePage(),
      ),
    );
  }
}
