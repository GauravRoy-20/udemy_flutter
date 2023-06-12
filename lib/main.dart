import "package:flutter/material.dart";
import "gradient_container.dart";

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          colors: [
            Color.fromARGB(255, 72, 39, 127),
            Color.fromARGB(255, 85, 4, 117)
          ],
        ),
      ),
    ),
  );
}
