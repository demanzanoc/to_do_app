import '../entities/user.dart';
import '../repositories/login_repository.dart';

class SignInUseCase {
  final LoginRepository repository;

  SignInUseCase({required this.repository});

  Future<void> call(User user) {
    return repository.signIn(user);
  }
}
