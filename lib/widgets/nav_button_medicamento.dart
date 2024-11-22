// widgets/nav_button_medicamento.dart
import 'package:flutter/material.dart';
import '../screens/medicamento_screen.dart';

class NavButtonMedicamento extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MedicamentoScreen()),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/icons/pastilla.png', // Icono personalizado de Medicamento
            height: 35,
          ),
          SizedBox(height: 4),
          Text('MEDICAMENTO', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
