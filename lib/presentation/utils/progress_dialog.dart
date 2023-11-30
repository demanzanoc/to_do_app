import 'package:flutter/material.dart';

class ProgressDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              const CircularProgressIndicator(),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: const Text('Cargando'),
              ),
            ],
          ),
        );
      },
    );
  }
}
