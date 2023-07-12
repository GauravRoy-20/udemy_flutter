import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/shopping_list/data/categories.dart';
import 'package:udemy_flutter/shopping_list/models/grocery_item.dart';
import 'package:udemy_flutter/shopping_list/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> groceryItems = [];
  late Future<List<GroceryItem>> loadedItems;
  String? error;
  @override
  void initState() {
    super.initState();
    loadedItems = loadItems();
  }

  Future<List<GroceryItem>> loadItems() async {
    final url = Uri.https(
        'flutter-shop-e2d2c-default-rtdb.firebaseio.com', "shopping-list.json");

    final response = await http.get(url);
    if (response.statusCode >= 400) {
      throw Exception("Failed to fetch grocery item. Please try again later.");
    }
    if (response.body == 'null') {
      return [];
    }
    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadedItems = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
              (cartItem) => cartItem.value.title == item.value["category"])
          .value;
      loadedItems.add(
        GroceryItem(
          id: item.key,
          name: item.value["name"],
          quantity: item.value["quantity"],
          category: category,
        ),
      );
    }

    return loadedItems;
  }

  void addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }
    setState(() {
      groceryItems.add(newItem);
    });
  }

  void removeItem(GroceryItem item) async {
    final index = groceryItems.indexOf(item);
    setState(() {
      groceryItems.remove(item);
    });
    final url = Uri.https('flutter-shop-e2d2c-default-rtdb.firebaseio.com',
        "shopping-list/${item.id}.json");
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      groceryItems.insert(index, item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
        actions: [
          IconButton(
            onPressed: addItem,
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.0,
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text("No item add yet."));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) {
              return Dismissible(
                onDismissed: (direction) {
                  removeItem(snapshot.data![index]);
                },
                key: ValueKey(snapshot.data![index].id),
                child: ListTile(
                  title: Text(snapshot.data![index].name),
                  leading: Container(
                    width: 24,
                    height: 24,
                    color: snapshot.data![index].category.color,
                  ),
                  trailing: Text(snapshot.data![index].quantity.toString()),
                ),
              );
            },
          );
        }),
        future: loadedItems,
      ),
    );
  }
}
