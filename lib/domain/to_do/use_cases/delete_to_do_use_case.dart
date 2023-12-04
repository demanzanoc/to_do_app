import 'package:to_do_app/domain/to_do/repositories/to_do_repository.dart';

class DeleteToDoUseCase {
  final ToDoRepository repository;

  DeleteToDoUseCase({required this.repository});

  Future<void> call(String toDoId, String userId) =>
      repository.deleteToDo(toDoId, userId);
}
