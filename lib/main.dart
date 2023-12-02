import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/presentation/login/providers/login_provider.dart';
import 'package:to_do_app/presentation/to_do/providers/to_do_provider.dart';
import 'data/firebase_options.dart';
import 'presentation/login/pages/login_page.dart';
import 'package:to_do_app/di/dependency_injector.dart' as dependency_injector;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dependency_injector.initInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => dependency_injector.di<LoginProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => dependency_injector.di<ToDoProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'To Do App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LoginPage(),
      ),
    );
  }
}
