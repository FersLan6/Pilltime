import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class MasScreen extends StatelessWidget {
  const MasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Más')),
      body: const Center(
        child: Text('Opciones adicionales aquí.'),
      ),
      bottomNavigationBar:
          const BottomNavBar(selectedIndex: 2), // Índice del botón "Más"
    );
  }
}
