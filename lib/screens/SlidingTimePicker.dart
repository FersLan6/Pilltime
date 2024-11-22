import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlidingTimePicker extends StatefulWidget {
  final TimeOfDay initialTime;
  final Function(TimeOfDay) onTimeChanged;

  const SlidingTimePicker({
    super.key,
    required this.initialTime,
    required this.onTimeChanged,
  });

  @override
  State<SlidingTimePicker> createState() => _SlidingTimePickerState();
}

class _SlidingTimePickerState extends State<SlidingTimePicker> {
  late int selectedHour; // Hora seleccionada (0-23)
  late int selectedMinute; // Minuto seleccionado
  late String period; // AM/PM basado en la hora

  @override
  void initState() {
    super.initState();
    selectedHour = widget.initialTime.hour;
    selectedMinute = widget.initialTime.minute;
    period = _getPeriod(selectedHour);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Selector de horas
        Expanded(
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(
              initialItem: selectedHour,
            ),
            itemExtent: 40,
            onSelectedItemChanged: (hour) {
              setState(() {
                selectedHour = hour;
                period = _getPeriod(selectedHour); // Actualiza AM/PM
              });
              _updateTime();
            },
            children: List.generate(24, (hour) {
              return Center(
                child: Text(
                  hour.toString().padLeft(2, '0'),
                  style: const TextStyle(fontSize: 20),
                ),
              );
            }),
          ),
        ),
        // Selector de minutos
        Expanded(
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(
              initialItem: selectedMinute,
            ),
            itemExtent: 40,
            onSelectedItemChanged: (minute) {
              setState(() {
                selectedMinute = minute;
              });
              _updateTime();
            },
            children: List.generate(60, (minute) {
              return Center(
                child: Text(
                  minute.toString().padLeft(2, '0'),
                  style: const TextStyle(fontSize: 20),
                ),
              );
            }),
          ),
        ),
        // Indicador AM/PM
        Expanded(
          child: Center(
            child: Text(
              period,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  String _getPeriod(int hour) {
    return (hour >= 0 && hour < 12) ? 'AM' : 'PM';
  }

  void _updateTime() {
    // Devuelve el tiempo actualizado
    widget.onTimeChanged(
      TimeOfDay(hour: selectedHour, minute: selectedMinute),
    );
  }
}
