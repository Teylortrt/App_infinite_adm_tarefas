import 'package:flutter/material.dart';
import 'package:infinite/screens/login/login_page.dart'; 
import 'package:infinite/screens/registrer_screen/registrer/registrer_page.dart';
 

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1980BA), // Cor de fundo azul
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Título e ícone
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Infinite',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset('assets/infinite.png'), // Substitua pelo seu caminho de imagem
                ],
              ),
              const SizedBox(height: 20),
              // Subtítulo
              const Text(
                'Simples, flexível e poderoso. Mantenha tudo em um só lugar.',
                style: TextStyle(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Imagem
              Image.asset('assets/produtividade.png'), // Substitua pelo seu caminho de imagem
              const SizedBox(height: 40),
              // Botões
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navegar para a página de Login
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: const Text(
                      'Iniciar Sessão',
                      style: TextStyle(color: Colors.black), // Cor do texto
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navegar para a página de Registro
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistrerPage()),
                      );
                    },
                    child: const Text(
                      'Criar Conta',
                      style: TextStyle(color: Colors.black), // Cor do texto
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
