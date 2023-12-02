import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/domain/to_do/entities/to_do.dart';
import 'package:to_do_app/domain/to_do/entities/to_do_status.dart';

class ToDoModel extends ToDo {
  const ToDoModel({
    required super.title,
    required super.description,
    required super.date,
    super.status,
  });

  Map<String, dynamic> toApiModel() => {
        'title': title,
        'description': description,
        'date': date,
        'status': status.name,
      };

  factory ToDoModel.fromApiModel(Map<String, dynamic> toDo) {
    DateTime date = toDo['date'] is Timestamp
        ? (toDo['date'] as Timestamp).toDate()
        : DateTime.parse(toDo['date'].toString());
    return ToDoModel(
      title: toDo['title'],
      description: toDo['description'],
      date: date,
      status: ToDoStatusExtension.fromString(toDo['status']),
    );
  }
}
