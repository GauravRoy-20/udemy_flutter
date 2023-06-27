import 'package:flutter/material.dart';
import 'package:udemy_flutter/todo/screens/todo_screen.dart';

class ToDo extends StatelessWidget {
  const ToDo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ToDoScreen(),
    );
  }
}
