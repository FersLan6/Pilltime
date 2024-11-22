import 'package:flutter/material.dart';
import '../main.dart'; // Importar la lista global

class AddMedicationFormScreen extends StatefulWidget {
  @override
  _AddMedicationFormScreenState createState() =>
      _AddMedicationFormScreenState();
}

class _AddMedicationFormScreenState extends State<AddMedicationFormScreen> {
  int currentStep = 0;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  int timesPerDay = 1;
  List<bool> selectedDays = List.filled(7, false);
  DateTime endDate = DateTime.now();

  void saveMedication() {
    medicamentos.add({
      'nombre': nameController.text,
      'dosis': quantityController.text,
      'vecesAlDia': timesPerDay,
      'dias': selectedDays,
      'fechaFinal': endDate.toLocal().toString().split(' ')[0],
    });

    print('Medicamento guardado: $medicamentos');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Medicamento'),
      ),
      body: Stepper(
        currentStep: currentStep,
        onStepContinue: () {
          if (currentStep < 2) {
            setState(() {
              currentStep += 1;
            });
          } else {
            saveMedication();
          }
        },
        onStepCancel: currentStep == 0
            ? null
            : () {
                setState(() {
                  currentStep -= 1;
                });
              },
        steps: [
          Step(
            title: Text("Información básica"),
            content: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Nombre del medicamento",
                    prefixIcon: Icon(Icons.medical_services),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: quantityController,
                  decoration: InputDecoration(
                    labelText: "Dosis (mg, ml, etc.)",
                    prefixIcon: Icon(Icons.medication),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            isActive: currentStep == 0,
          ),
          Step(
            title: Text("Frecuencia y días"),
            content: Column(
              children: [
                DropdownButtonFormField<int>(
                  value: timesPerDay,
                  onChanged: (value) {
                    setState(() {
                      timesPerDay = value!;
                    });
                  },
                  items: List.generate(
                    4,
                    (index) => DropdownMenuItem(
                      value: index + 1,
                      child: Text("${index + 1} veces al día"),
                    ),
                  ),
                  decoration: InputDecoration(
                    labelText: "Veces al día",
                    prefixIcon: Icon(Icons.timer),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: List.generate(7, (index) {
                    final days = [
                      "Lun",
                      "Mar",
                      "Mié",
                      "Jue",
                      "Vie",
                      "Sáb",
                      "Dom"
                    ];
                    return FilterChip(
                      label: Text(days[index]),
                      selected: selectedDays[index],
                      onSelected: (value) {
                        setState(() {
                          selectedDays[index] = value;
                        });
                      },
                    );
                  }),
                ),
              ],
            ),
            isActive: currentStep == 1,
          ),
          Step(
            title: Text("Fecha de finalización"),
            content: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: endDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null) {
                      setState(() => endDate = picked);
                    }
                  },
                  child: Text("Seleccionar fecha"),
                ),
                SizedBox(height: 8),
                Text("Fecha seleccionada: ${endDate.toLocal()}".split(' ')[0]),
              ],
            ),
            isActive: currentStep == 2,
          ),
        ],
      ),
    );
  }
}
