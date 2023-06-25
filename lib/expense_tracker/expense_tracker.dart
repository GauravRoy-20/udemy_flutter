import 'package:flutter/material.dart';
import 'package:udemy_flutter/expense_tracker/screens/expense_screen.dart';

var expenseColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(155, 96, 59, 181),
);
var expenseDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(155, 5, 99, 125),
  brightness: Brightness.dark,
);

class ExpenseTracker extends StatelessWidget {
  const ExpenseTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: expenseDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: expenseDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: expenseDarkColorScheme.primaryContainer,
            foregroundColor: expenseDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: expenseColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: expenseColorScheme.onPrimaryContainer,
          foregroundColor: expenseColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: expenseColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: expenseColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: expenseColorScheme.onSecondaryContainer,
                fontSize: 14,
              ),
            ),
      ),
      themeMode: ThemeMode.system,
      home: const ExpenseScreen(),
    );
  }
}
