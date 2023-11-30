import 'package:flutter/cupertino.dart';
import '../../../presentation/login/providers/login_state.dart';
import '../../../domain/login/entities/user.dart';
import '../../../domain/login/use_cases/sign_in_use_case.dart';
import '../../../domain/login/use_cases/sign_up_use_case.dart';

class LoginProvider extends ChangeNotifier {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  LoginState _loginState = LoginState.initial;

  LoginProvider({required this.signInUseCase, required this.signUpUseCase});

  LoginState get state => _loginState;

  Future<void> signIn(String email, String password) async {
    _loginState = LoginState.loading;
    notifyListeners();
    try {
      await signInUseCase.call(_createUser(email, password));
      _loginState = LoginState.success;
    } catch (_) {
      _loginState = LoginState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password) async {
    _loginState = LoginState.loading;
    notifyListeners();
    try {
      await signUpUseCase.call(_createUser(email, password));
      _loginState = LoginState.success;
    } catch (_) {
      _loginState = LoginState.error;
    } finally {
      notifyListeners();
    }
  }

  User _createUser(String email, String password) =>
      User(email: email, password: password);

  void resetState() {
    _loginState = LoginState.initial;
    notifyListeners();
  }

}
