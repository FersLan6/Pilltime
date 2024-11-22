// widgets/nav_button_mas.dart
import 'package:flutter/material.dart';
import '../screens/mas_screen.dart';

class NavButtonMas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MasScreen()),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/icons/punto.png', // Icono personalizado de Medicamento
            height: 35,
          ),
          SizedBox(height: 4),
          Text('MAS', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
