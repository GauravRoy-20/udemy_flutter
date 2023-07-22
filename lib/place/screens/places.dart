import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:udemy_flutter/place/providers/user_places.dart';
import 'package:udemy_flutter/place/screens/add_place.dart';
import 'package:udemy_flutter/place/screens/places_list.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PlacesScreenState();
  }
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> placeFuture;

  @override
  void initState() {
    super.initState();
    placeFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const AddPlaceScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          8.0,
        ),
        child: FutureBuilder(
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : PlacesList(
                      places: userPlaces,
                    ),
        ),
      ),
    );
  }
}
