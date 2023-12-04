import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/presentation/to_do/providers/to_do_provider.dart';
import '../widgets/to_do_card.dart';
import '../widgets/to_do_form_alert_dialog.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final toDoProvider = context.watch<ToDoProvider>();
    toDoProvider.getToDoList();
    final DateTime currentTime = DateTime.now();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lista de tareas',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.calendar_month_sharp,
                  size: 20,
                  color: Colors.deepPurple,
                ),
                const SizedBox(width: 10),
                Text(
                  'Día de hoy: ${currentTime.day.toString().padLeft(2, '0')}'
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
            Expanded(
              child: FutureBuilder<void>(
                future: toDoProvider.getToDoList(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: toDoProvider.toDoList.length,
                    itemBuilder: (_, index) {
                      return ToDoCard(
                        toDo: toDoProvider.toDoList[index],
                        index: index,
                      );
                    },
                  );
                },
              ),
            ),
          ],
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
