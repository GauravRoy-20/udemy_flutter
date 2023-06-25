import 'package:flutter/material.dart';
import 'package:udemy_flutter/expense_tracker/models/expense.dart';
import 'package:udemy_flutter/expense_tracker/widgets/expense_item.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expenses,
    required this.deleteExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) deleteExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal,
            ),
          ),
          onDismissed: (direction) {
            deleteExpense(expenses[index]);
          },
          child: ExpenseItem(expenses[index]),
        );
      },
      itemCount: expenses.length,
    );
  }
}
