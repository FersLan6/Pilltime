import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlidingTimePicker extends StatefulWidget {
  final TimeOfDay initialTime;
  final Function(TimeOfDay) onTimeChanged;
  final bool isToday; // Indica si el día seleccionado es hoy

  const SlidingTimePicker({
    super.key,
    required this.initialTime,
    required this.onTimeChanged,
    required this.isToday,
  });

  @override
  State<SlidingTimePicker> createState() => _SlidingTimePickerState();
}

class _SlidingTimePickerState extends State<SlidingTimePicker> {
  late int selectedHour;
  late int selectedMinute;
  bool hasExceededDay = false; // Verifica si se excedió al siguiente día

  @override
  void initState() {
    super.initState();
    selectedHour = widget.initialTime.hour;
    selectedMinute = widget.initialTime.minute;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final currentHour = now.hour;
    final currentMinute = now.minute;

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
              if (widget.isToday && hour < currentHour) {
                // Restringe horas pasadas si el día es hoy
                return;
              }

              setState(() {
                selectedHour = hour;
                hasExceededDay =
                    selectedHour >= 24; // Detecta si se excedió el día
                if (hasExceededDay) {
                  selectedHour %= 24; // Ajusta la hora al rango de 0-23
                }

                if (widget.isToday && selectedHour == currentHour) {
                  // Ajusta minutos automáticamente si es necesario
                  selectedMinute = currentMinute;
                }
              });
              _updateTime();
            },
            children: List.generate(48, (hour) {
              final displayHour =
                  hour % 24; // Asegura que las horas estén en el rango de 0-23
              final isDisabled =
                  widget.isToday && hour < currentHour && hour < 24;
              return Center(
                child: Text(
                  displayHour.toString().padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: 20,
                    color: isDisabled ? Colors.grey : Colors.black,
                  ),
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
              if (widget.isToday &&
                  selectedHour == currentHour &&
                  minute < currentMinute) {
                // Restringe minutos pasados si el día es hoy
                return;
              }

              setState(() {
                selectedMinute = minute;
              });
              _updateTime();
            },
            children: List.generate(60, (minute) {
              final isDisabled = widget.isToday &&
                  selectedHour == currentHour &&
                  minute < currentMinute;
              return Center(
                child: Text(
                  minute.toString().padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: 20,
                    color: isDisabled ? Colors.grey : Colors.black,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  void _updateTime() {
    final updatedHour = hasExceededDay ? selectedHour + 24 : selectedHour;

    widget.onTimeChanged(
      TimeOfDay(hour: updatedHour % 24, minute: selectedMinute),
    );
  }
}
