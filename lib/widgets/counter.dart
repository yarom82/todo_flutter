import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Counter extends StatelessWidget {
  final int _counter;

  Counter(this._counter);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.center,
      child: Text('Remains: $_counter', style: Theme.of(context).textTheme.title,),
    );
  }
}
