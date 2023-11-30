import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import '../data/login/data_sources/login_remote_data_source.dart';
import '../data/login/repositories/login_remote_repository.dart';
import '../domain/login/repositories/login_repository.dart';
import '../domain/login/use_cases/sign_in_use_case.dart';
import '../presentation/login/providers/login_provider.dart';
import '../domain/login/use_cases/sign_up_use_case.dart';

final di = GetIt.instance;

Future<void> initInjection() async {
  //Providers
  di.registerFactory<LoginProvider>(
    () => LoginProvider(signInUseCase: di.call(), signUpUseCase: di.call()),
  );

  //UseCases
  di.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(repository: di.call()),
  );
  di.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(repository: di.call()),
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
