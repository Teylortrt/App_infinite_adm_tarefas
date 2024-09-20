import 'package:flutter/material.dart';

class RegistrerPage extends StatelessWidget {
  const RegistrerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegistrerPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RegistrerPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
