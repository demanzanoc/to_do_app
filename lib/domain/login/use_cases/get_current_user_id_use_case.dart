import 'package:to_do_app/domain/login/repositories/login_repository.dart';

class GetCurrentUserIdUseCase {
  final LoginRepository repository;

  GetCurrentUserIdUseCase({required this.repository});

  Future<String> call() => repository.getCurrentUserId();
}
