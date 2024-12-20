import 'package:flutter/material.dart';
import '../models/medicamento_model.dart';
import '../helpers/database_helper.dart';

class EditMedicationPage extends StatefulWidget {
  final Medicamento medicamento;

  const EditMedicationPage({super.key, required this.medicamento});

  @override
  State<EditMedicationPage> createState() => _EditMedicationPageState();
}

class _EditMedicationPageState extends State<EditMedicationPage> {
  late TextEditingController _nameController;
  late TextEditingController _doseController;
  late List<bool> _selectedDays;
  late int _vecesAlDia;
  late List<TimeOfDay> _horarios;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.medicamento.nombre);
    _doseController = TextEditingController(text: widget.medicamento.dosis);
    _selectedDays = List<bool>.from(widget.medicamento.dias);
    _vecesAlDia = widget.medicamento.vecesAlDia;
    _horarios = widget.medicamento.horarios.map((hora) => _parseTime(hora)).toList();
  }

  TimeOfDay _parseTime(String hora) {
    final parts = hora.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1].split(' ')[0]);
    final isPM = hora.contains('PM') && hour != 12;
    return TimeOfDay(hour: isPM ? hour + 12 : hour, minute: minute);
  }

  Future<void> _saveChanges() async {
    final updatedMedicamento = Medicamento(
      id: widget.medicamento.id,
      nombre: _nameController.text,
      dosis: _doseController.text,
      dias: _selectedDays,
      horarios: _horarios.map((time) => time.format(context)).toList(),
      fechaFin: widget.medicamento.fechaFin,
      vecesAlDia: _vecesAlDia,
    );

    await DatabaseHelper.instance.updateMedicamento(updatedMedicamento);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Medicamento actualizado correctamente')),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Medicamento'),
        backgroundColor: Colors.teal.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre del medicamento'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _doseController,
              decoration: const InputDecoration(labelText: 'Dosis'),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: List.generate(7, (index) {
                return ChoiceChip(
                  label: Text(['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'][index]),
                  selected: _selectedDays[index],
                  onSelected: (selected) {
                    setState(() {
                      _selectedDays[index] = selected;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              value: _vecesAlDia,
              items: List.generate(4, (index) {
                return DropdownMenuItem(
                  value: index + 1,
                  child: Text('${index + 1} veces al día'),
                );
              }),
              onChanged: (value) {
                setState(() {
                  _vecesAlDia = value!;
                  if (_horarios.length > _vecesAlDia) {
                    _horarios = _horarios.sublist(0, _vecesAlDia);
                  } else {
                    _horarios.addAll(
                      List.generate(
                        _vecesAlDia - _horarios.length,
                        (_) => TimeOfDay.now(),
                      ),
                    );
                  }
                });
              },
              decoration: const InputDecoration(
                labelText: 'Veces al día',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Editar horarios:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ...List.generate(_horarios.length, (index) {
              return ListTile(
                title: Text('Horario ${index + 1}'),
                trailing: IconButton(
                  icon: const Icon(Icons.access_time),
                  onPressed: () async {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: _horarios[index],
                    );
                    if (pickedTime != null) {
                      setState(() {
                        _horarios[index] = pickedTime;
                      });
                    }
                  },
                ),
                subtitle: Text('Hora: ${_horarios[index].format(context)}'),
              );
            }),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveChanges,
              child: const Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
