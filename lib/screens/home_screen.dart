import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/bottom_nav_bar.dart';
import '../screens/add_medication_page1.dart';
import '../helpers/database_helper.dart'; // Importa la base de datos
import '../models/medicamento_model.dart'; // Importa el modelo de medicamento

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Medicamento> medicamentos = [];

  @override
  void initState() {
    super.initState();
    _loadMedicamentos(); // Carga los medicamentos al iniciar
  }

  Future<void> _loadMedicamentos() async {
    final loadedMedicamentos = await DatabaseHelper.instance.getMedicamentos();
    setState(() {
      medicamentos = loadedMedicamentos;
    });
  }

  @override
  Widget build(BuildContext context) {
    String today = DateTime.now().weekday.toString();
    List<Medicamento> todaysMeds = medicamentos.where((med) {
      return med.dias[int.parse(today) - 1];
    }).toList();

    final now = DateTime.now();

    todaysMeds = todaysMeds
        .map((med) {
          final filteredHorarios = med.horarios.where((hora) {
            final horarioParts = hora.split(':');
            final hour = int.parse(horarioParts[0]);
            final minute = int.parse(horarioParts[1].split(' ')[0]);
            final isPM = hora.contains('PM') && hour != 12;
            final medicationTime = DateTime(
              now.year,
              now.month,
              now.day,
              isPM ? hour + 12 : hour,
              minute,
            );
            return medicationTime.isAfter(now);
          }).toList();

          return Medicamento(
            id: med.id,
            nombre: med.nombre,
            dosis: med.dosis,
            dias: med.dias,
            horarios: filteredHorarios,
            fechaFin: med.fechaFin,
            vecesAlDia: med.vecesAlDia, // Asegúrate de incluir este campo
          );
        })
        .where((med) => med.horarios.isNotEmpty)
        .toList();

    Map<String, List<Medicamento>> groupedMeds = {};
    for (var med in todaysMeds) {
      for (var horario in med.horarios) {
        if (!groupedMeds.containsKey(horario)) {
          groupedMeds[horario] = [];
        }
        groupedMeds[horario]!.add(med);
      }
    }

    return Scaffold(
      appBar: customAppBar(
        logoSize: 40,
        backgroundColor: const Color.fromARGB(255, 89, 197, 93),
      ),
      body: Column(
        children: [
          const CalendarWidget(),
          const SizedBox(height: 16),
          Expanded(
            child: groupedMeds.isEmpty
                ? const Center(
                    child: Text(
                      'No hay medicamentos pendientes para hoy.',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView(
                    children: groupedMeds.entries.map((entry) {
                      String hora = entry.key;
                      List<Medicamento> meds = entry.value;

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.shade100,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hora: $hora',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...meds.map((med) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  '${med.nombre} - Dosis: ${med.dosis}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          ),
          const SizedBox(height: 8),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddMedicationPage1()),
                ).then((_) => _loadMedicamentos());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade200,
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.green, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              child: const Text(
                'AÑADIR MEDICAMENTOS',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }
}
