import 'package:flutter/material.dart';

import 'gradient_container.dart';

class Dice extends StatelessWidget {
  const Dice({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
            Color.fromARGB(255, 72, 39, 127), Color.fromARGB(255, 85, 4, 117)),
      ),
    );
  }
}
