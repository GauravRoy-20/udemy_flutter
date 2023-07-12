import 'package:flutter/material.dart';
import 'package:udemy_flutter/shopping_list/data/categories.dart';
import 'package:udemy_flutter/shopping_list/models/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:udemy_flutter/shopping_list/models/grocery_item.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final formKey = GlobalKey<FormState>();
  var name = "";
  var quantity = 1;
  var defaultCategory = categories[Categories.vegetables]!;
  var isSending = false;
  void saveItem() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() {
        isSending = true;
      });
      final url = Uri.https('flutter-shop-e2d2c-default-rtdb.firebaseio.com',
          "shopping-list.json");
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            "name": name,
            "quantity": quantity,
            "category": defaultCategory.title,
          },
        ),
      );

      final Map<String, dynamic> resData = json.decode(response.body);
      if (!context.mounted) {
        return;
      }

      Navigator.of(context).pop(
        GroceryItem(
          id: resData['name'],
          name: name,
          quantity: quantity,
          category: defaultCategory,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text("Name"),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length >= 50) {
                      return "Must be between 2 and 50 characters.";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name = value!;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text(
                            "Quantity",
                          ),
                        ),
                        initialValue: quantity.toString(),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0) {
                            return "Must be a positive valid number.";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          quantity = int.parse(value!);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                          value: defaultCategory,
                          items: [
                            for (final category in categories.entries)
                              DropdownMenuItem(
                                value: category.value,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      color: category.value.color,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(category.value.title),
                                  ],
                                ),
                              )
                          ],
                          onChanged: (value) {
                            setState(() {
                              defaultCategory = value!;
                            });
                          }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: isSending
                          ? null
                          : () {
                              formKey.currentState!.reset();
                            },
                      child: const Text(
                        "Reset",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: isSending ? null : saveItem,
                      child: isSending
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.0,
                              ),
                            )
                          : const Text(
                              "Add Item",
                            ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
