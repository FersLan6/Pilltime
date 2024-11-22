import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/bottom_nav_bar.dart';
import '../main.dart';
import '../screens/add_medication_page1.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Filtra y agrupa los medicamentos para el día actual
    String today = DateTime.now().weekday.toString();
    List<Map<String, dynamic>> todaysMeds = medicamentos.where((med) {
      return med['dias'][int.parse(today) - 1] == true;
    }).toList();

    // Agrupa los medicamentos por hora
    Map<String, List<Map<String, dynamic>>> groupedMeds = {};
    for (var med in todaysMeds) {
      for (var horario in med['horarios']) {
        if (!groupedMeds.containsKey(horario)) {
          groupedMeds[horario] = [];
        }
        groupedMeds[horario]!.add(med);
      }
    }

    return Scaffold(
      appBar: customAppBar(),
      body: Column(
        children: [
          const CalendarWidget(),
          const SizedBox(height: 16),
          Expanded(
            child: groupedMeds.isEmpty
                ? const Center(child: Text('No hay medicamentos para hoy.'))
                : ListView(
                    children: groupedMeds.entries.map((entry) {
                      String hora = entry.key;
                      List<Map<String, dynamic>> meds = entry.value;

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hora: $hora',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...meds.map((med) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    '${med['nombre']} - Dosis: ${med['dosis']} - ${med['vecesAlDia']} veces al día',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
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
                  MaterialPageRoute(builder: (context) => AddMedicationPage1()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[100],
                side: const BorderSide(color: Colors.blue, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              child: const Text(
                'AÑADIR MEDICAMENTOS',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {}); // Actualiza la lista de medicamentos al regresar
  }
}
