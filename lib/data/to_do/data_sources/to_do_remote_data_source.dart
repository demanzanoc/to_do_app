import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/data/to_do/models/to_do_model.dart';
import 'package:to_do_app/domain/to_do/entities/to_do.dart';

class ToDoRemoteDataSource {
  final FirebaseFirestore database;

  ToDoRemoteDataSource(this.database);

  final String _refUserCollection = 'users';
  final String _refToDoCollection = 'to_dos';

  Future<void> setToDo(String userId, ToDo toDo) async {
    final userCollection = database.collection(_refUserCollection);
    final toDoModel = ToDoModel(
      title: toDo.title,
      description: toDo.description,
      date: toDo.date,
    ).toApiModel();
    try {
      await userCollection
          .doc(userId)
          .collection(_refToDoCollection)
          .doc()
          .set(toDoModel);
    } catch (exception) {
      throw Exception(exception);
    }
  }

  Stream<List<ToDo>> getToDoList(String userId) {
    try {
      final toDoCollection = database
          .collection(_refUserCollection)
          .doc(userId)
          .collection(_refToDoCollection);
      return toDoCollection.snapshots().map((querySnapshot) => querySnapshot
          .docs
          .map((toDo) => ToDoModel.fromApiModel(toDo.id, toDo.data()))
          .toList());
    } catch (exception) {
      throw Exception(exception);
    }
  }

  Future<void> changeToDoStatus(
    String userId,
    String toDoId,
    String toDoStatus,
  ) async {
    try {
      final toDoRef = database
          .collection(_refUserCollection)
          .doc(userId)
          .collection(_refToDoCollection)
          .doc(toDoId);
      await toDoRef.update({'status': toDoStatus});
    } catch (exception) {
      throw Exception(exception);
    }
  }

  Future<void> deleteToDo(String toDoId, String userId) async {
    try {
      final toDoRef = database
          .collection(_refUserCollection)
          .doc(userId)
          .collection(_refToDoCollection)
          .doc(toDoId);
      toDoRef.delete();
    } catch (exception) {
      throw Exception(exception);
    }
  }
}
