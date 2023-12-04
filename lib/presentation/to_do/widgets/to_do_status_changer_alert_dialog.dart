import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/domain/to_do/entities/to_do_status.dart';
import 'package:to_do_app/presentation/to_do/providers/to_do_provider.dart';

class ToDoStatusChangerAlertDialog extends StatelessWidget {
  final int index;
  final String toDoId;

  const ToDoStatusChangerAlertDialog({
    super.key,
    required this.index,
    required this.toDoId,
  });

  @override
  Widget build(BuildContext context) {
    final toDoProvider = context.watch<ToDoProvider>();
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Actualizar estado'),
          IconButton(
            icon: const Icon(
              Icons.close,
              size: 30,
              color: Colors.deepPurple,
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: const Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Icon(Icons.assignment_sharp, color: Colors.amber),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              toDoProvider.changeToDoStatus(toDoId, ToDoStatus.toDo);
            },
          ),
          InkWell(
            child: const Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Icon(Icons.hourglass_bottom, color: Colors.blue),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              toDoProvider.changeToDoStatus(toDoId, ToDoStatus.inProgress);
            },
          ),
          InkWell(
            child: const Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Icon(Icons.task_alt, color: Colors.green),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              toDoProvider.changeToDoStatus(toDoId, ToDoStatus.done);
            },
          ),
        ],
      ),
    );
  }
}
