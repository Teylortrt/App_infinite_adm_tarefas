import 'package:flutter/material.dart';
import 'dart:async';  // Necessário para usar o temporizador

import 'package:infinite/screens/home/home_page.dart';  // Tela de destino após a splash screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),  // Define a SplashScreen como a tela inicial
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Define um temporizador para 3 segundos (3000 milissegundos)
    Timer(const Duration(seconds: 3), () {
      // Após o tempo definido, navega para a TelaInicial
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TelaInicial()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1980BA),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'infinite',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Image.asset(
              'assets/infinite.png',
              width: 100,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
