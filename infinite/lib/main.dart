import 'package:flutter/material.dart';
import 'package:infinite/screens/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF1980BA),
        body: GestureDetector(
          onTap: () {
            // Navegar para a tela Home ao clicar
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TelaInicial()),
            );
          },
          child: Center(
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
        ),
      ),
    );
  }
}
