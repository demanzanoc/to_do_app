import 'package:flutter/material.dart';
import 'package:to_do_app/domain/to_do/entities/to_do.dart';
import 'package:to_do_app/domain/to_do/entities/to_do_status.dart';

class ToDoCard extends StatelessWidget {
  final ToDo toDo;

  const ToDoCard({super.key, required this.toDo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    toDo.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(toDo.description),
                  Text(
                      '${toDo.date.day.toString().padLeft(2, '0')}'
                          '-${toDo.date.month.toString().padLeft(2, '0')}'
                          '-${toDo.date.year}',
                      style: const TextStyle(color: Colors.deepPurple)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: _createIcon(toDo.status),
            )
          ],
        ),
      ),
    );
  }

  Icon _createIcon(ToDoStatus toDoStatus) {
    switch (toDoStatus) {
      case ToDoStatus.toDo:
        return const Icon(Icons.assignment_sharp, color: Colors.amber);
      case ToDoStatus.inProgress:
        return const Icon(Icons.hourglass_bottom, color: Colors.blue);
      case ToDoStatus.done:
        return const Icon(Icons.task_alt, color: Colors.green);
      default:
        return const Icon(Icons.assignment_sharp, color: Colors.amber);
    }
  }
}
