import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Todos",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.amber,
        fontSize: 75,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
