import 'package:to_do_app/domain/login/repositories/login_repository.dart';

import '../entities/user.dart';

class SignUpUseCase {
  final LoginRepository repository;

  SignUpUseCase({required this.repository});

  Future<void> call(User user) => repository.signUp(user);

}
