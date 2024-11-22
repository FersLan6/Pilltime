import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/medicamento_screen.dart';
import '../screens/mas_screen.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green.shade100, // Fondo más claro
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Sombra ligera
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Botón Inicio
          _buildNavItem(
            context,
            iconPath: 'assets/icons/casa.png',
            label: 'INICIO',
            isSelected: selectedIndex == 0,
            onTap: () {
              if (selectedIndex != 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              }
            },
          ),
          // Botón Medicamentos
          _buildNavItem(
            context,
            iconPath: 'assets/icons/pastilla.png',
            label: 'MEDICAMENTOS',
            isSelected: selectedIndex == 1,
            onTap: () {
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
          _buildNavItem(
            context,
            iconPath: 'assets/icons/punto.png',
            label: 'MÁS',
            isSelected: selectedIndex == 2,
            onTap: () {
              if (selectedIndex != 2) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MasScreen()),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required String iconPath,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.green : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              iconPath,
              height: 24,
              color: isSelected ? Colors.white : Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.green : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
