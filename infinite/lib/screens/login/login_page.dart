import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:infinite/screens/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:infinite/screens/custom_text_field.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});

 final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: const Color(0xFF1980BA),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Adicionando a imagem acima do texto "Seja bem-vindo de volta"
                Image.asset(
                  'assets/infinite.png',
                  height: 150,  // Ajuste a altura conforme necessário
                ),
                const SizedBox(height: 16), // Espaço entre a imagem e o texto
                const Text(
                  'Seja bem-vindo de volta!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: Colors.black), // Alterado para preto
                ),
                const SizedBox(height: 50), // Ajuste o tamanho para alterar o posicionamento
                CustomTextField(
                  label: 'Email',
                  inputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || !EmailValidator.validate(value)) {
                      return 'Email inválido';
                    }
                    return null;
                  },
                  controller: _emailController,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Senha',
                  inputType: TextInputType.visiblePassword,
                  isPassword: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Senha inválida';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Logar o usuário
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.black, // Cor preta
                  ),
                  child: const Text('Conecte-se'),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/registrer');
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.black, // Cor preta
                  ),
                  child: const Text('Registre-se'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}