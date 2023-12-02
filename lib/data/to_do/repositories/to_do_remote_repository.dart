import 'package:to_do_app/data/to_do/data_sources/to_do_remote_data_source.dart';
import 'package:to_do_app/domain/to_do/entities/to_do.dart';
import 'package:to_do_app/domain/to_do/repositories/to_do_repository.dart';

class ToDoRemoteRepository implements ToDoRepository {
  final ToDoRemoteDataSource remoteDataSource;

  ToDoRemoteRepository({required this.remoteDataSource});

  @override
  Future<void> setToDo(userId, toDo) => remoteDataSource.setToDo(userId, toDo);

  @override
  Stream<List<ToDo>> getToDoList(userId) =>
      remoteDataSource.getToDoList(userId);
}
