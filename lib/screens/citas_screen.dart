import 'package:flutter/material.dart';

class CitasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Citas'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          'Pantalla de Citas',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
