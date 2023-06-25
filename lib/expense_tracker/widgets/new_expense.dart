import 'package:flutter/material.dart';
import 'package:udemy_flutter/expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({required this.addExpense, super.key});
  final void Function(Expense expense) addExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;
  Category selectedCategory = Category.leisure;

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(
      () {
        selectedDate = pickedDate;
      },
    );
  }

  void handleSubmitExpense() {
    final enteredAmount = double.tryParse(amountController.text);
    final invalidAmount = enteredAmount == null || enteredAmount <= 0;
    if (titleController.text.trim().isEmpty ||
        invalidAmount ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            "Invalid input",
          ),
          content: const Text(
            "Please make sure a valid title, amount, date and category was entered..",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text(
                "Okay",
              ),
            )
          ],
        ),
      );
      return;
    }
    widget.addExpense(
      Expense(
        title: titleController.text,
        amount: enteredAmount,
        date: selectedDate!,
        category: selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text(
                "Title",
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    label: Text(
                      "Amount",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      selectedDate == null
                          ? "No date selected"
                          : formatter.format(selectedDate!),
                    ),
                    IconButton(
                      onPressed: datePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                  value: selectedCategory,
                  items: Category.values
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      selectedCategory = value;
                    });
                  }),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                ),
              ),
              ElevatedButton(
                onPressed: handleSubmitExpense,
                child: const Text(
                  "Save Expense",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
