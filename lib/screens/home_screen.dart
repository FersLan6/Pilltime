import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/add_med_button.dart';
import '../widgets/bottom_nav_bar.dart';
import '../main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Filtra medicamentos para el día actual
    String today =
        DateTime.now().weekday.toString(); // Obtén el día como número (1=lunes)
    List<Map<String, dynamic>> todaysMeds = medicamentos.where((med) {
      return med['dias'][int.parse(today) - 1] == true;
    }).toList();

    return Scaffold(
      appBar: customAppBar(),
      body: Column(
        children: [
          const CalendarWidget(),
          const SizedBox(height: 16),
          // Medicamentos para hoy
          todaysMeds.isEmpty
              ? const Center(
                  child: Text('No hay medicamentos para hoy.'),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: todaysMeds.length,
                    itemBuilder: (context, index) {
                      final med = todaysMeds[index];
                      return ListTile(
                        title: Text(med['nombre']),
                        subtitle: Text(
                            'Dosis: ${med['dosis']} - ${med['vecesAlDia']} veces al día'),
                      );
                    },
                  ),
                ),
          const Spacer(),
          const AddMedButton(),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }
}
