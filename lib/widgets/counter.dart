import 'package:flutter/widgets.dart';

class Counter extends StatelessWidget {
  final int _counter;

  Counter(this._counter);

  @override
  Widget build(BuildContext context) {
    return Text('Counter $_counter');
  }
}
