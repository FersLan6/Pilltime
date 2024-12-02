import 'package:flutter/material.dart';
import 'package:pilltime/screens/home_screen.dart';
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
    times = List.generate(widget.timesPerDay, (_) => TimeOfDay.now());
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
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurar Horarios'),
        backgroundColor: Colors.teal.shade400,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFe3ffe7), Color(0xFFd9e7ff)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // Sección: Selección de horarios
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Selecciona los horarios:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      ...List.generate(
                        widget.timesPerDay,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Horario ${index + 1}:',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Sección: Fecha de finalización
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Fecha de finalización:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              endDate = pickedDate;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.teal.shade300),
                          ),
                          child: Text(
                            endDate != null
                                ? '${endDate!.day.toString().padLeft(2, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.year}'
                                : 'Selecciona una fecha',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Botón Guardar
              ElevatedButton(
                onPressed: saveMedication,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.teal.shade500,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Guardar', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
