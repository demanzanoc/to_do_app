import 'package:flutter/material.dart';

class SimpleSnackBar {
  static void show(BuildContext context, { String message = 'Ha ocurrido un error' }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
