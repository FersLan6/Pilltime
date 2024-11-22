import 'package:flutter/material.dart';
import 'add_medication_page2.dart';

class AddMedicationPage1 extends StatefulWidget {
  const AddMedicationPage1({super.key});

  @override
  State<AddMedicationPage1> createState() => _AddMedicationPage1State();
}

class _AddMedicationPage1State extends State<AddMedicationPage1> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _doseController = TextEditingController();
  int _timesPerDay = 1;
  List<bool> _selectedDays = List.generate(7, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Añadir Medicamento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Información básica:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre del medicamento'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _doseController,
              decoration: const InputDecoration(labelText: 'Dosis (mg, ml, etc.)'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Frecuencia y días:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButton<int>(
              value: _timesPerDay,
              onChanged: (value) {
                setState(() {
                  _timesPerDay = value!;
                });
              },
              items: List.generate(4, (index) {
                return DropdownMenuItem(
                  value: index + 1,
                  child: Text('${index + 1} veces al día'),
                );
              }),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: List.generate(7, (index) {
                return ChoiceChip(
                  label: Text(['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'][index]),
                  selected: _selectedDays[index],
                  onSelected: (selected) {
                    setState(() {
                      _selectedDays[index] = selected;
                    });
                  },
                );
              }),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isEmpty || _doseController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Por favor completa todos los campos')),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddMedicationPage2(
                      name: _nameController.text,
                      dose: _doseController.text,
                      timesPerDay: _timesPerDay,
                      selectedDays: _selectedDays,
                    ),
                  ),
                );
              },
              child: const Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}
