import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_app/data/to_do/data_sources/to_do_remote_data_source.dart';
import 'package:to_do_app/data/to_do/repositories/to_do_remote_repository.dart';
import 'package:to_do_app/domain/login/use_cases/get_current_user_id_use_case.dart';
import 'package:to_do_app/domain/to_do/repositories/to_do_repository.dart';
import 'package:to_do_app/domain/to_do/use_cases/change_to_do_status_use_case.dart';
import 'package:to_do_app/domain/to_do/use_cases/get_to_do_list_use_case.dart';
import 'package:to_do_app/domain/to_do/use_cases/set_to_do_use_case.dart';
import 'package:to_do_app/presentation/to_do/providers/to_do_provider.dart';
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
    () => LoginProvider(
      signInUseCase: di.call(),
      signUpUseCase: di.call(),
      getCurrentUserIdUseCase: di.call(),
    ),
  );
  di.registerFactory<ToDoProvider>(
    () => ToDoProvider(
      setToDoUseCase: di.call(),
      getCurrentUserIdUseCase: di.call(),
      getToDoListUseCase: di.call(),
      changeToDoStatusUseCase: di.call(),
    ),
  );

  //UseCases
  di.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(repository: di.call()),
  );
  di.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(repository: di.call()),
  );
  di.registerLazySingleton<GetCurrentUserIdUseCase>(
    () => GetCurrentUserIdUseCase(repository: di.call()),
  );
  di.registerLazySingleton<SetToDoUseCase>(
    () => SetToDoUseCase(repository: di.call()),
  );
  di.registerLazySingleton<GetToDoListUseCase>(
    () => GetToDoListUseCase(repository: di.call()),
  );
  di.registerLazySingleton<ChangeToDoStatusUseCase>(
    () => ChangeToDoStatusUseCase(repository: di.call()),
  );

  //Repositories
  di.registerLazySingleton<LoginRepository>(
    () => LoginRemoteRepository(remoteDataSource: di.call()),
  );
  di.registerLazySingleton<ToDoRepository>(
    () => ToDoRemoteRepository(remoteDataSource: di.call()),
  );

  //DataSources
  di.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSource(di.call()),
  );
  di.registerLazySingleton<ToDoRemoteDataSource>(
    () => ToDoRemoteDataSource(di.call()),
  );

  //Providers Dependencies
  di.registerLazySingleton(() => FirebaseAuth.instance);
  di.registerLazySingleton(() => FirebaseFirestore.instance);
}
