import 'package:flutter/material.dart';
import 'package:udemy_flutter/expense_tracker/widgets/chart/chart.dart';
import 'package:udemy_flutter/expense_tracker/widgets/expense_list.dart';
import 'package:udemy_flutter/expense_tracker/widgets/new_expense.dart';
import '../models/expense.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final List<Expense> expenseData = [
    Expense(
      title: "Flutter Course",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Cinema",
      amount: 15.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void handleAddExpense() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(
          addExpense: addExpense,
        );
      },
    );
  }

  void addExpense(Expense expense) {
    setState(() {
      expenseData.add(expense);
    });
  }

  void deleteExpense(Expense expense) {
    final deleteExpenseIndex = expenseData.indexOf(expense);
    setState(
      () {
        expenseData.remove(expense);
      },
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(
          seconds: 3,
        ),
        content: const Text(
          "Expense deleted.",
        ),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(
              () {
                expenseData.insert(deleteExpenseIndex, expense);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget expenseList = const Center(
      child: Text(
        "No expense found. Start adding some!",
      ),
    );

    if (expenseData.isNotEmpty) {
      expenseList = ExpenseList(
        expenses: expenseData,
        deleteExpense: deleteExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
            onPressed: handleAddExpense,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: expenseData),
          Expanded(
            child: expenseList,
          )
        ],
      ),
    );
  }
}
