import '../entities/to_do.dart';

abstract class ToDoRepository {
  Future<void> setToDo(userId, toDo);
  Stream<List<ToDo>> getToDoList(userId);
}
