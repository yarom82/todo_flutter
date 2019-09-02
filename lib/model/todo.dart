import 'package:flutter/foundation.dart';

class Todo with ChangeNotifier {
  
  final String id;
  final String title;
  final bool isDone;

  Todo({
    this.id,
    @required this.title,
    @required this.isDone,
  });
}
