import 'package:flutter/cupertino.dart';
import 'package:to_do_app/presentation/to_do/providers/input_form_state.dart';
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
  InputFormState _formState = InputFormState.initial;

  LoginProvider({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.getCurrentUserIdUseCase,
  });

  RequestState get loginState => _loginState;
  InputFormState get formState => _formState;

  Future<void> signIn(String email, String password) async {
    _validateFields(email, password);
    if (_formState == InputFormState.completed) {
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
  }

  Future<void> signUp(String email, String password) async {
    _validateFields(email, password);
    if (_formState == InputFormState.completed) {
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
  }

  void _validateFields(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      if (password.length >= 6) {
        _formState = InputFormState.completed;
      } else {
        _formState = InputFormState.incomplete;
      }
    } else {
      _formState = InputFormState.incomplete;
    }
    notifyListeners();
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

  void resetState() {
    _loginState = RequestState.initial;
    notifyListeners();
  }

}
