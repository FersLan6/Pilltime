import 'package:flutter/material.dart';
import '../screens/slidingTimePicker.dart';
import '../main.dart';

class AddMedicationPage2 extends StatefulWidget {
  final String name;
  final String dose;
  final int timesPerDay;
  final List<bool> selectedDays;

  const AddMedicationPage2({
    super.key,
    required this.name,
    required this.dose,
    required this.timesPerDay,
    required this.selectedDays,
  });

  @override
  State<AddMedicationPage2> createState() => _AddMedicationPage2State();
}

class _AddMedicationPage2State extends State<AddMedicationPage2> {
  List<TimeOfDay> times = [];
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    final now = TimeOfDay.now();
    times = List.generate(widget.timesPerDay, (_) => now);
  }

  void saveMedication() {
    if (endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecciona una fecha final.'),
        ),
      );
      return;
    }

    // Crear el medicamento
    final medicamento = {
      'nombre': widget.name,
      'dosis': widget.dose,
      'horarios': times.map((time) => time.format(context)).toList(),
      'dias': widget.selectedDays,
      'fechaFin': endDate?.toLocal().toString().split(' ')[0],
      'vecesAlDia': widget.timesPerDay,
    };

    // Guardar en la lista global
    medicamentos.add(medicamento);

    // Mostrar mensaje de éxito
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Medicamento guardado exitosamente.')),
    );

    // Redirigir a la pantalla principal
    Navigator.pop(context); // Regresa al formulario 1
    Navigator.pop(
        context); // Regresa a la pantalla anterior (Inicio o Medicamentos)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurar Horarios')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selecciona los horarios:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Generación de relojes deslizantes
            ...List.generate(
              widget.timesPerDay,
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Horario ${index + 1}:',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  SlidingTimePicker(
                    initialTime: times[index],
                    onTimeChanged: (newTime) {
                      setState(() {
                        times[index] = newTime;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const Text(
              'Fecha de finalización del tratamiento:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final newDate = await showDatePicker(
                  context: context,
                  initialDate: endDate ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (newDate != null) {
                  setState(() {
                    endDate = newDate;
                  });
                }
              },
              child: Text(
                endDate != null
                    ? 'Fecha seleccionada: ${endDate!.toLocal()}'.split(' ')[0]
                    : 'Seleccionar fecha',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: saveMedication,
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
