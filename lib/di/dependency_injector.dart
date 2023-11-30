import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_app/data/login/data_sources/login_remote_data_source.dart';
import 'package:to_do_app/data/login/repositories/login_remote_repository.dart';
import 'package:to_do_app/domain/login/repositories/login_repository.dart';
import 'package:to_do_app/domain/login/use_cases/sign_in_use_case.dart';
import 'package:to_do_app/presentation/login/providers/login_provider.dart';

final di = GetIt.instance;

Future<void> initInjection() async {
  //Providers
  di.registerFactory<LoginProvider>(
    () => LoginProvider(signInUseCase: di.call()),
  );

  //UseCases
  di.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(repository: di.call()),
  );

  //Repositories
  di.registerLazySingleton<LoginRepository>(
    () => LoginRemoteRepository(remoteDataSource: di.call()),
  );

  //DataSources
  di.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSource(di.call()),
  );

  //Providers Dependencies
  di.registerLazySingleton(() => FirebaseAuth.instance);
}
