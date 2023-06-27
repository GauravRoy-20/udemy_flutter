import 'package:flutter/material.dart';
import 'package:udemy_flutter/todo/widgets/keys/keys.dart';
import 'package:udemy_flutter/todo/widgets/ui_updates_demo.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ToDo",
        ),
      ),
      body: const Keys(),
      // const UIUpdatesDemo(),
    );
  }
}
