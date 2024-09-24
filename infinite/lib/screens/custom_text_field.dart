import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextInputType inputType;
  final bool isPassword;
  final TextInputAction action;
  final TextEditingController? controller;
  final String? Function(String?) validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.inputType,
    this.isPassword = false,
    this.controller,
    required this.validator,
    this.action = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey), // Rótulo em cinza
          filled: true,
          fillColor: Colors.grey[200], // Cor de fundo em cinza claro
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30), // Borda circular
            borderSide: const BorderSide(color: Colors.grey), // Cor da borda
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30), // Borda ao habilitar
            borderSide: const BorderSide(color: Colors.grey), // Cor da borda
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30), // Borda ao focar
            borderSide: const BorderSide(color: Colors.blue), // Cor da borda ao focar
          ),
        ),
        keyboardType: inputType,
        obscureText: isPassword,
        textInputAction: action,
      ),
    );
  }
}