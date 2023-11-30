import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const Button({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        child: Text(text, style: const TextStyle(fontSize: 17)),
      ),
    );
  }
}
