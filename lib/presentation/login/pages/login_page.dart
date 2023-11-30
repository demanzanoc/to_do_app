import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/presentation/login/providers/login_provider.dart';
import 'package:to_do_app/presentation/login/widgets/button.dart';
import 'package:to_do_app/presentation/login/widgets/input_text_field.dart';
import 'package:to_do_app/presentation/utils/progress_dialog.dart';
import 'package:to_do_app/presentation/utils/simple_snack_bar.dart';
import '../providers/login_state.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LoginProvider>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _manageState(loginProvider, context);
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 100),
                child: Column(
                  children: <Widget>[
                    const Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      'To-Do Manager',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    Text(
                      'Ingresar',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 40,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          InputTextField(
                            hintText: 'Correo',
                            controller: emailController,
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          InputTextField(
                            hintText: 'Contraseña',
                            controller: passwordController,
                            icon: Icons.password,
                            obscureText: true,
                          ),
                          Button(
                            text: 'Iniciar sesión',
                            onPressed: () => _signIn(
                              loginProvider,
                              emailController.text,
                              passwordController.text,
                            ),
                          ),
                          Button(
                            text: 'Registrarse',
                            onPressed: () => _signUp(
                              loginProvider,
                              emailController.text,
                              passwordController.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn(LoginProvider loginProvider, String email, String password) {
    loginProvider.signIn(email, password);
  }

  void _signUp(LoginProvider loginProvider, String email, String password) {
    loginProvider.signUp(email, password);
  }

  void _manageState(LoginProvider loginProvider, BuildContext context) {
    switch (loginProvider.state) {
      case LoginState.initial:
        break;
      case LoginState.loading:
        ProgressDialog.show(context);
        loginProvider.resetState();
        break;
      case LoginState.success:
        Navigator.of(context).pop();
        SimpleSnackBar.show(
          context,
          message: 'Usuario autenticado',
        );
        break;
      case LoginState.error:
        Navigator.of(context).pop();
        SimpleSnackBar.show(
          context,
          message: 'Ha ocurrido un error intentando autenticarse',
        );
        loginProvider.resetState();
        break;
      default:
        break;
    }
  }
}
