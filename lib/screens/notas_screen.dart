import 'package:flutter/material.dart';

class NotasScreen extends StatelessWidget {
  const NotasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notas'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          'Pantalla de Notas',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
