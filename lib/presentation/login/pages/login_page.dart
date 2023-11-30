import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                      'Iniciar Sesión',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 40,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(labelText: 'Correo'),
                          ),
                          TextField(
                            decoration:
                                InputDecoration(labelText: 'Contraseña'),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Procesando...')),
                          );
                        },
                        child: const Text('Ingresar'),
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
}
