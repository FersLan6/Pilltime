// widgets/nav_button_inicio.dart
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class NavButtonInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/icons/casa.png', // Icono personalizado de Inicio
            height: 30,
          ),
          SizedBox(height: 4),
          Text('INICIO', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
