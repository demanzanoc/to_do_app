import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/domain/to_do/entities/to_do.dart';
import 'package:to_do_app/domain/to_do/entities/to_do_status.dart';
import 'package:to_do_app/presentation/to_do/providers/to_do_provider.dart';

class ToDoCard extends StatelessWidget {
  final ToDo toDo;
  final int index;

  const ToDoCard({super.key, required this.toDo, required this.index});

  @override
  Widget build(BuildContext context) {
    final toDoProvider = context.watch<ToDoProvider>();
    return Card(
      elevation: 4,
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
                    toDoProvider.getTranslationStates(index)
                        ? toDo.toDoTranslated?.title ?? toDo.title
                        : toDo.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    toDoProvider.getTranslationStates(index)
                        ? toDo.toDoTranslated?.description ?? toDo.description
                        : toDo.description,
                  ),
                  Text(
                    '${toDo.date.day.toString().padLeft(2, '0')}'
                    '-${toDo.date.month.toString().padLeft(2, '0')}'
                    '-${toDo.date.year}',
                    style: const TextStyle(color: Colors.deepPurple),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _createIcon(toDo.status),
                  ),
                  InkWell(
                    onTap: () => toDoProvider.toggleTranslation(index),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.g_translate, color: Colors.blue),
                    ),
                  ),
                ],
              ),
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
