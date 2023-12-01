import 'package:equatable/equatable.dart';
import 'package:to_do_app/domain/to_do/entities/to_do_status.dart';

class ToDo extends Equatable {
  final String title;
  final String description;
  final DateTime date;
  final ToDoStatus status;

  const ToDo({
    required this.title,
    required this.description,
    required this.date,
    this.status = ToDoStatus.toDo,
  });

  @override
  List<Object?> get props => [title, description, date, status];
}
