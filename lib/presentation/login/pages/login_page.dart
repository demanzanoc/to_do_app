import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/presentation/login/providers/login_provider.dart';
import 'package:to_do_app/presentation/login/widgets/button.dart';
import 'package:to_do_app/presentation/login/widgets/input_text_field.dart';

import '../../../domain/login/entities/user.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LoginProvider>();
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
                          const InputTextField(
                            labelText: 'Correo',
                            hintText: 'Ingrese su correo',
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const InputTextField(
                            labelText: 'Contraseña',
                            hintText: 'Ingrese su contraseña',
                            icon: Icons.password,
                            obscureText: true,
                          ),
                          Button(
                            text: 'Iniciar sesión',
                            onPressed: () => _login(
                              loginProvider,
                              User(
                                email: 'demanzanoc07@gmail.com',
                                password: '1234567890',
                              ),
                            ),
                          ),
                          Button(text: 'Registrarse', onPressed: () {}),
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

  void _login(LoginProvider loginProvider, User user) {
    loginProvider.signInUseCase.call(user);
  }
}
