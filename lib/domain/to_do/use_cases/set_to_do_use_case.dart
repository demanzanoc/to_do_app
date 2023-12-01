
import 'package:to_do_app/domain/to_do/entities/to_do.dart';
import 'package:to_do_app/domain/to_do/repositories/to_do_repository.dart';

class SetToDoUseCase {
  final ToDoRepository repository;

  SetToDoUseCase({required this.repository});

  Future<void> call(String userId, ToDo toDo) => repository.setToDo(userId, toDo);

}