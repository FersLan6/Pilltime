import 'package:flutter/material.dart';
import '../screens/add_medication_form_screen.dart';

class AddMedButton extends StatelessWidget {
  const AddMedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddMedicationFormScreen(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow[100],
        side: const BorderSide(color: Colors.blue, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      ),
      child: const Text(
        'AÑADIR MEDICAMENTOS',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
