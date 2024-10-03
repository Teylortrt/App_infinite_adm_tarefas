import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_tasks/add_tasks_page.dart';
import 'package:infinite/principal/principal_page.dart';
import 'package:infinite/screens/home/home_page.dart';
import 'package:infinite/screens/login/login_page.dart';
import 'package:infinite/screens/registrer_screen/registrer/registrer_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      initialRoute: '/',  // Define a tela inicial
      routes: {
        '/': (context) => const TelaInicial(),  // Página inicial
        '/login': (context) => LoginPage(),  // Tela de login
        '/registrer': (context) =>  RegistrerPage(),  // Tela de registro
        '/principal': (context) =>  PrincipalPage(),  // Página principal após login ou registro
      },
    );
  }
}
