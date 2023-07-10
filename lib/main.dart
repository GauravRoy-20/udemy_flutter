import "package:flutter/material.dart";
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:udemy_flutter/meal/meal.dart';

void main() {
  runApp(
    const ProviderScope(
      child: Meal(),
    ),
  );
}
