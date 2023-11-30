import 'package:flutter/material.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(),
      floatingActionButton: FloatingActionButton(
        tooltip: '',
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
