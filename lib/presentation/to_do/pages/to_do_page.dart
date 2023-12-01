import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/presentation/to_do/providers/to_do_provider.dart';
import '../widgets/to_do_form_alert_dialog.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ToDoProvider toDoProvider = context.watch<ToDoProvider>();
    final DateTime currentTime = DateTime.now();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 40, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Lista de tareas',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 20,
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${currentTime.day.toString().padLeft(2, '0')}'
                    '-${currentTime.month.toString().padLeft(2, '0')}'
                    '-${currentTime.year}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Agregar nueva tarea',
        onPressed: () => showDialog(
          context: context,
          builder: (context) => ToDoFormAlertDialog(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
