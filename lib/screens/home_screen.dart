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

    //Esto controla el color del fondo del logo
    return Scaffold(
      appBar: customAppBar(
        logoSize: 40, // Tamaño del logo
        backgroundColor: const Color.fromARGB(255, 89, 197, 93), // Color claro para el fondo
      ),
      body: Column(
        children: [
          const CalendarWidget(),
          const SizedBox(height: 16),
          // Medicamentos para hoy
          Expanded(
            child: groupedMeds.isEmpty
                ? const Center(
                    child: Text(
                      'No hay medicamentos para hoy.',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView(
                    children: groupedMeds.entries.map((entry) {
                      String hora = entry.key;
                      List<Map<String, dynamic>> meds = entry.value;

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
                                  '${med['nombre']} - Dosis: ${med['dosis']} - ${med['vecesAlDia']} veces al día',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              );
                            }).toList(),
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
                  MaterialPageRoute(builder: (context) => AddMedicationPage1()),
                );
              },
              //Este controla codigo del boton agregar
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
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {}); // Actualiza la lista de medicamentos al regresar
  }
}
