import 'package:flutter/material.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1980BA), // Cor de fundo azul
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Título e ícone
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Infinite',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset('assets/infinite.png'), // Substitua por seu caminho
                ],
              ),
              const SizedBox(height: 20),
              // Subtítulo
              Text(
                'Simples, flexível e poderoso. Mantenha tudo em um só lugar.',
                style: TextStyle(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Imagem
              Image.asset('assets/produtividade.png'), // Substitua por seu caminho
              const SizedBox(height: 40),
              // Botões
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para iniciar sessão
                      print('Iniciar Sessão');
                    },
                    child: Text(
                      'Iniciar Sessão',
                      style: TextStyle(color: Colors.black), // Aqui definimos a cor do texto
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para criar conta
                      print('Criar Conta');
                    },
                    child: Text(
                      'Criar Conta',
                      style: TextStyle(color: Colors.black), // Aqui também
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