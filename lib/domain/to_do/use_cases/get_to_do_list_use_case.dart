import 'package:to_do_app/domain/to_do/entities/to_do.dart';
import 'package:to_do_app/domain/to_do/repositories/to_do_repository.dart';

class GetToDoListUseCase {
  final ToDoRepository repository;

  GetToDoListUseCase({required this.repository});

  Stream<List<ToDo>> call(String userId) => repository.getToDoList(userId);
}
