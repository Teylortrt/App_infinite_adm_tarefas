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
      body: Container(
        color: Color(0xFF1980BA)),
      appBar: AppBar(
        title: Text('seja bem-vindo de volta'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //Logar o mano
                  }
                },
                child: const Text('Entrar'),
              ),
              SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/registrer');
                },
                child: Text('Registre-se'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

