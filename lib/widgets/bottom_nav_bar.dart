import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/medicamento_screen.dart';
import '../screens/mas_screen.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  const BottomNavBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.green[300], // Fondo verde
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Botón Inicio
          IconButton(
            icon: Column(
              children: [
                Image.asset('assets/icons/casa.png', height: 24),
                Text(
                  'INICIO',
                  style: TextStyle(
                    fontSize: 10,
                    color: selectedIndex == 0 ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            onPressed: () {
              if (selectedIndex != 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              }
            },
          ),
          // Botón Medicamentos
          IconButton(
            icon: Column(
              children: [
                Image.asset('assets/icons/pastilla.png', height: 24),
                Text(
                  'MEDICAMENTOS',
                  style: TextStyle(
                    fontSize: 10,
                    color: selectedIndex == 1 ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            onPressed: () {
              if (selectedIndex != 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MedicamentoScreen()),
                );
              }
            },
          ),
          // Botón Más
          IconButton(
            icon: Column(
              children: [
                Image.asset('assets/icons/punto.png', height: 24),
                Text(
                  'MÁS',
                  style: TextStyle(
                    fontSize: 10,
                    color: selectedIndex == 2 ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            onPressed: () {
              if (selectedIndex != 2) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MasScreen()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
