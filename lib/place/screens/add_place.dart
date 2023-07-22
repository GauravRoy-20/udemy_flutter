import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:udemy_flutter/place/models/place.dart';
import 'package:udemy_flutter/place/providers/user_places.dart';
import 'package:udemy_flutter/place/widgets/image_input.dart';
import 'package:udemy_flutter/place/widgets/location_input.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final titleController = TextEditingController();
  File? selectedImage;
  PlaceLocation? selectedLocation;
  void savePlace() {
    final enteredText = titleController.text;
    if (enteredText.isEmpty || selectedImage == null) {
      return;
    }
    ref.read(userPlacesProvider.notifier).addPlace(
          enteredText,
          selectedImage!,
          selectedLocation!,
        );
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Place"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
              controller: titleController,
            ),
            const SizedBox(
              height: 10,
            ),
            ImageInput(
              onPickImage: (image) {
                selectedImage = image;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            LocationInput(onSelectLocation: (location) {
              selectedLocation = location;
            }),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              onPressed: savePlace,
              icon: const Icon(
                Icons.add,
              ),
              label: const Text(
                "Add Place",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
