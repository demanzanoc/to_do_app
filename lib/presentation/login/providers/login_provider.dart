import 'package:flutter/cupertino.dart';
import 'package:to_do_app/domain/login/use_cases/sign_in_use_case.dart';

class LoginProvider extends ChangeNotifier {
  final SignInUseCase signInUseCase;

  LoginProvider({required this.signInUseCase});
}
