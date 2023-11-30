import '../entities/user.dart';

abstract class LoginRepository {
  Future<void> signIn(User user);
}