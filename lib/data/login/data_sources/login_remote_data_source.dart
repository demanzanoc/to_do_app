import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/domain/login/entities/user.dart' as user_entity;

class LoginRemoteDataSource {
  final FirebaseAuth auth;

  LoginRemoteDataSource(this.auth);

  Future<void> signIn(user_entity.User user) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
    } catch (exception) {
      throw Exception(exception);
    }
  }

  Future<void> signUp(user_entity.User user) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
    } catch (exception) {
      throw Exception(exception);
    }
  }

  Future<String> getCurrentUserId() async {
    try {
      return auth.currentUser?.uid ?? '';
    } catch (exception) {
      throw Exception(exception);
    }
  }
}
