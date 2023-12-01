import 'package:flutter/cupertino.dart';
import '../../../domain/login/use_cases/get_current_user_id_use_case.dart';
import '../../shared/providers/request_state.dart';
import '../../../domain/login/entities/user.dart';
import '../../../domain/login/use_cases/sign_in_use_case.dart';
import '../../../domain/login/use_cases/sign_up_use_case.dart';

class LoginProvider extends ChangeNotifier {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final GetCurrentUserIdUseCase getCurrentUserIdUseCase;
  RequestState _loginState = RequestState.initial;

  LoginProvider({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.getCurrentUserIdUseCase,
  });

  RequestState get state => _loginState;

  Future<void> signIn(String email, String password) async {
    _loginState = RequestState.loading;
    notifyListeners();
    try {
      await signInUseCase.call(_createUser(email, password));
      _loginState = RequestState.success;
    } catch (_) {
      _loginState = RequestState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password) async {
    _loginState = RequestState.loading;
    notifyListeners();
    try {
      await signUpUseCase.call(_createUser(email, password));
      _loginState = RequestState.success;
    } catch (_) {
      _loginState = RequestState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<String> getCurrentUserId() async {
    try {
      return await getCurrentUserIdUseCase.call();
    } catch (exception) {
      throw Exception(exception);
    }
  }

  User _createUser(String email, String password) =>
      User(email: email, password: password);
}
