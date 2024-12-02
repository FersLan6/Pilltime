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
              if (widget.isToday && hour < currentHour) return; // Restringe horas pasadas
              setState(() {
                selectedHour = hour;
                if (widget.isToday && selectedHour == currentHour) {
                  // Ajusta los minutos automáticamente si es necesario
                  selectedMinute = currentMinute;
                }
              });
              _updateTime();
            },
            children: List.generate(24, (hour) {
              final isDisabled = widget.isToday && hour < currentHour;
              return Center(
                child: Text(
                  hour.toString().padLeft(2, '0'),
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
                  minute < currentMinute) return; // Restringe minutos pasados
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
    widget.onTimeChanged(
      TimeOfDay(hour: selectedHour, minute: selectedMinute),
    );
  }
}
