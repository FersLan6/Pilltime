import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final PageController _pageController = PageController(initialPage: 0);
  DateTime _baseDate = DateTime.now(); // Base date to calculate weeks

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Nombre del mes en español y en mayúsculas
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            DateFormat('MMMM yyyy', 'es_ES').format(_baseDate).toUpperCase(), // Convierte a mayúsculas
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        // PageView de las semanas
        SizedBox(
          height: 100,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                // Calcula la semana basada en la página actual
                _baseDate = DateTime.now().add(Duration(days: 7 * index));
              });
            },
            itemBuilder: (context, weekIndex) {
              // Calcula el inicio de la semana basada en `weekIndex`
              DateTime weekStart = DateTime.now().add(Duration(days: 7 * weekIndex));
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(7, (dayIndex) {
                  DateTime day = weekStart.add(Duration(days: dayIndex));
                  bool isToday = DateTime.now().day == day.day &&
                                 DateTime.now().month == day.month &&
                                 DateTime.now().year == day.year;
                  return Column(
                    children: [
                      Text(
                        DateFormat('EEE', 'es_ES').format(day).toUpperCase(), // Día de la semana en español
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text(
                        '${day.day}',
                        style: TextStyle(
                          color: isToday ? Colors.blue : Colors.black,
                          fontSize: isToday ? 20 : 18,
                          fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}
