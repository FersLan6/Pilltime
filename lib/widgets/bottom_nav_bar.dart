import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/mas_screen.dart';
import '../screens/medicamento_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Column(
              children: [
                Image.asset('assets/icons/casa.png', height: 24),
                const SizedBox(height: 2),
                const Text('INICIO', style: TextStyle(fontSize: 10)),
              ],
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
          IconButton(
            icon: Column(
              children: [
                Image.asset('assets/icons/pastilla.png', height: 24),
                const SizedBox(height: 2),
                const Text('MEDICAMENTOS', style: TextStyle(fontSize: 10)),
              ],
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MedicamentoScreen()),
              );
            },
          ),
          IconButton(
            icon: Column(
              children: [
                Image.asset('assets/icons/punto.png', height: 24),
                const SizedBox(height: 2),
                const Text('MÁS', style: TextStyle(fontSize: 10)),
              ],
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MasScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
