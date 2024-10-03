import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:infinite/screens/custom_text_field.dart';
import 'package:infinite/screens/principal/principal_page.dart';
import 'package:infinite/screens/registrer_screen/registrer/registrer_page.dart';
import 'package:infinite/main.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _login(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final email = _emailController.text;
    final password = _passwordController.text;

    // Simula uma verificação simples de login
    final savedEmail = prefs.getString('email') ?? '';
    final savedPassword = prefs.getString('password') ?? '';

    if (email == savedEmail && password == savedPassword) {
      // Se o login for bem-sucedido, redireciona para a página principal
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PrincipalPage()),
      );
    } else {
      // Mostra mensagem de erro se o login falhar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email ou senha inválidos!')),
      );
    }
  }

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
                Image.asset(
                  'assets/infinite.png',
                  height: 150,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Seja bem-vindo de volta!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
                const SizedBox(height: 50),
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
                      _login(context);
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Text('Conecte-se'),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/registrer'); // Navega para a página de registro
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.black,
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
