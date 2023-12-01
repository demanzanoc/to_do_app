import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/presentation/login/providers/login_provider.dart';
import 'package:to_do_app/presentation/login/widgets/button.dart';
import 'package:to_do_app/presentation/login/widgets/input_text_field.dart';
import 'package:to_do_app/presentation/to_do/pages/to_do_page.dart';
import 'package:to_do_app/presentation/utils/progress_dialog.dart';
import 'package:to_do_app/presentation/utils/simple_snack_bar.dart';
import '../../shared/providers/request_state.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final LoginProvider loginProvider = context.watch<LoginProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _manageState(loginProvider, context);
    });
    return Scaffold(
      body: FutureBuilder<String?>(
        future: loginProvider.getCurrentUserId(),
        builder: (context, snapshot) {
          final userId = snapshot.data ?? '';
          if (userId.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const ToDoPage()),
              );
            });
          }
          return SingleChildScrollView(
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
                                  onPressed: () => loginProvider.signIn(
                                      emailController.text,
                                      passwordController.text)),
                              Button(
                                text: 'Registrarse',
                                onPressed: () => loginProvider.signUp(
                                    emailController.text,
                                    passwordController.text),
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
          );
        },
      ),
    );
  }

  void _manageState(LoginProvider loginProvider, BuildContext context) {
    switch (loginProvider.state) {
      case RequestState.initial:
        break;
      case RequestState.loading:
        ProgressDialog.show(context);
        break;
      case RequestState.success:
        _goToToDoPage(context);
        break;
      case RequestState.error:
        _showSimpleSnackBar(context);
        break;
      default:
        break;
    }
  }

  void _goToToDoPage(BuildContext context) {
    const String successLoginMessage = 'Usuario autenticado';
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ToDoPage()),
    );
    SimpleSnackBar.show(
      context,
      message: successLoginMessage,
    );
  }

  void _showSimpleSnackBar(BuildContext context) {
    const String errorLoginMessage =
        'Ha ocurrido un error intentando autenticarse';
    Navigator.of(context).pop();
    SimpleSnackBar.show(
      context,
      message: errorLoginMessage,
    );
  }
}
