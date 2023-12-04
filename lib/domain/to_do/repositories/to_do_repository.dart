import 'package:to_do_app/domain/to_do/entities/to_do_status.dart';

import '../entities/to_do.dart';

abstract class ToDoRepository {
  Future<void> setToDo(userId, toDo);

  Stream<List<ToDo>> getToDoList(userId);

  Future<void> changeToDoStatus(
    String userId,
    String toDoId,
    ToDoStatus toDoStatus,
  );
}
