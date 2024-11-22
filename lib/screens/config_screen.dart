import 'package:flutter/material.dart';

class ConfigScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          'Pantalla de Configuración',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
