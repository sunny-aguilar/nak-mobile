import 'package:flutter/material.dart';

class ChapterScreen extends StatelessWidget {
  const ChapterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 100.0,
            ),
            const Center(
              child: Text("Chapters Screen"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text("Go Back"),
            )
          ],
        ),
      );
  }
}