import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/domain/login/entities/user.dart' as user_entity;

class LoginRemoteDataSource {
  final FirebaseAuth auth;

  LoginRemoteDataSource(this.auth);

  Future<void> signIn(user_entity.User user) async {
    await auth.signInWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
  }

  Future<void> signUp(user_entity.User user) async {
    await auth.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
  }
}
