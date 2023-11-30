import 'package:to_do_app/domain/login/entities/user.dart';
import 'package:to_do_app/domain/login/repositories/login_repository.dart';

import '../data_sources/login_remote_data_source.dart';

class LoginRemoteRepository implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRemoteRepository({required this.remoteDataSource});

  @override
  Future<void> signIn(User user) async => remoteDataSource.signIn(user);

  @override
  Future<void> signUp(User user) async => remoteDataSource.signUp(user);
}
