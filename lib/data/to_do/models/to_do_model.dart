import 'package:to_do_app/domain/to_do/entities/to_do.dart';

class ToDoModel extends ToDo {
  const ToDoModel({
    required super.title,
    required super.description,
    required super.date,
    super.status,
  });

  Map<String, dynamic> toDocument() => {
        'title': title,
        'description': description,
        'date': date,
        'status': status.name,
      };
}
