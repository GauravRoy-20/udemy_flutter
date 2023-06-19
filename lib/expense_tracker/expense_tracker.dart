import 'package:flutter/material.dart';
import 'package:udemy_flutter/expense_tracker/expense_screen.dart';

class ExpenseTracker extends StatelessWidget {
  const ExpenseTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Expense(),
    );
  }
}
