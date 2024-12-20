import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/medicamento_model.dart';
import 'home_screen.dart';
import '../screens/slidingTimePicker.dart';

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

  Future<void> saveMedication() async {
    if (endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecciona una fecha final.'),
        ),
      );
      return;
    }

    final medicamento = Medicamento(
      id: DateTime.now().millisecondsSinceEpoch,
      nombre: widget.name,
      dosis: widget.dose,
      horarios: times.map((time) => time.format(context)).toList(),
      dias: widget.selectedDays,
      fechaFin: endDate?.toIso8601String(),
      vecesAlDia: widget.timesPerDay, // Incluye este campo
    );

    await DatabaseHelper.instance.insertMedicamento(medicamento);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Medicamento guardado correctamente.'),
        backgroundColor: Colors.teal.shade400,
      ),
    );

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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
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
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          SlidingTimePicker(
                            initialTime: times[index],
                            isToday: widget.selectedDays[
                                DateTime.now().weekday -
                                    1], // Detecta si es hoy
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
          ElevatedButton(
            onPressed: saveMedication,
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
