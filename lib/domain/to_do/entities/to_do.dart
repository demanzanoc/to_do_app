import 'package:equatable/equatable.dart';
import 'package:to_do_app/domain/to_do/entities/to_do_status.dart';
import 'package:to_do_app/domain/to_do/entities/to_do_translated.dart';

class ToDo extends Equatable {
  final String? toDoId;
  final String title;
  final String description;
  final DateTime date;
  final ToDoTranslated? toDoTranslated;
  final ToDoStatus status;

  const ToDo({
    this.toDoId,
    required this.title,
    required this.description,
    required this.date,
    this.toDoTranslated,
    this.status = ToDoStatus.toDo,
  });

  @override
  List<Object?> get props => [
        toDoId,
        title,
        description,
        date,
        toDoTranslated,
        status,
      ];
}
