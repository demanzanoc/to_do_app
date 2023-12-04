
import 'package:to_do_app/domain/to_do/entities/to_do_status.dart';
import 'package:to_do_app/domain/to_do/repositories/to_do_repository.dart';

class ChangeToDoStatusUseCase {
  final ToDoRepository repository;

  ChangeToDoStatusUseCase({required this.repository});

  Future<void> call(String userId, String toDoId, ToDoStatus toDoStatus,) =>
      repository.changeToDoStatus(userId, toDoId, toDoStatus);
}