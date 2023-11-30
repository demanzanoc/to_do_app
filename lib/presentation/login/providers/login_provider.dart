import 'package:flutter/cupertino.dart';
import '../../../domain/login/entities/user.dart';
import '../../../domain/login/use_cases/sign_in_use_case.dart';
import '../../../domain/login/use_cases/sign_up_use_case.dart';

class LoginProvider extends ChangeNotifier {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  LoginProvider({required this.signInUseCase, required this.signUpUseCase});

  Future<void> signIn(String email, String password) async {
    try {
      signInUseCase.call(_createUser(email, password));
    } catch (exception) {
      //TODO
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      signUpUseCase.call(_createUser(email, password));
    } catch (exception) {
      //TODO
    }
  }

  User _createUser(String email, String password) =>
      User(email: email, password: password);
}
