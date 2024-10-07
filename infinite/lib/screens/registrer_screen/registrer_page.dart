import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:infinite/screens/custom_text_field.dart';
import 'package:infinite/screens/principal/principal_page.dart';

class RegistrerPage extends StatelessWidget {
  RegistrerPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _register(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final email = _emailController.text;
    final password = _passwordController.text;

    // Salva o email e senha no SharedPreferences
    await prefs.setString('email', email);
    await prefs.setString('password', password);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Conta criada com sucesso!')),
    );

    // Redireciona para a página principal
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PrincipalPage()),
    );
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
                  'Crie sua conta',
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
                  label: 'Crie a sua senha',
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
                CustomTextField(
                  label: 'Repita sua senha',
                  inputType: TextInputType.visiblePassword,
                  isPassword: true,
                  controller: _repeatPasswordController,
                  validator: (value) {
                    if (value == null || value != _passwordController.text) {
                      return 'As senhas não coincidem';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _register(context);
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Text('Criar Conta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}