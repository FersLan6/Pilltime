import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'add_medication_page2.dart';

class AddMedicationPage1 extends StatefulWidget {
  const AddMedicationPage1({super.key});

  @override
  State<AddMedicationPage1> createState() => _AddMedicationPage1State();
}

class _AddMedicationPage1State extends State<AddMedicationPage1> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _doseController = TextEditingController();
  int _timesPerDay = 1;
  String? _doseType;
  final List<bool> _selectedDays = List.generate(7, (index) => false);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Medicamento'),
        backgroundColor: Colors.teal.shade400,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFe3ffe7), Color(0xFFd9e7ff)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      // Sección: Información básica
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
                                'Información básica:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Campo: Nombre del medicamento
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: 'Nombre del medicamento',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  prefixIcon: const Icon(Icons.medical_services_outlined),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, ingrese el nombre';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Campo: Cantidad y tipo
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      controller: _doseController,
                                      decoration: InputDecoration(
                                        labelText: 'Cantidad',
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Por favor, ingrese la cantidad';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    flex: 1,
                                    child: DropdownButtonFormField<String>(
                                      value: _doseType,
                                      isExpanded: true, // Asegura que no haya desbordamiento
                                      items: ['mg', 'ml', 'pastillas', 'cucharadas']
                                          .map((type) => DropdownMenuItem(
                                                value: type,
                                                child: Text(type),
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _doseType = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Tipo',
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      validator: (value) =>
                                          value == null ? 'Seleccione el tipo' : null,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Sección: Frecuencia
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
                                'Frecuencia:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              DropdownButtonFormField<int>(
                                value: _timesPerDay,
                                items: List.generate(4, (index) {
                                  return DropdownMenuItem(
                                    value: index + 1,
                                    child: Text('${index + 1} veces al día'),
                                  );
                                }),
                                onChanged: (value) {
                                  setState(() {
                                    _timesPerDay = value!;
                                  });
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Sección: Días
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
                                'Días:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                children: List.generate(7, (index) {
                                  return ChoiceChip(
                                    label: Text(
                                      ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom']
                                          [index],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    selected: _selectedDays[index],
                                    onSelected: (selected) {
                                      setState(() {
                                        _selectedDays[index] = selected;
                                      });
                                    },
                                    selectedColor: Colors.teal.shade300,
                                    backgroundColor: Colors.white,
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Botón Continuar
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddMedicationPage2(
                            name: _nameController.text,
                            dose: '${_doseController.text} $_doseType',
                            timesPerDay: _timesPerDay,
                            selectedDays: _selectedDays,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.teal.shade500,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Continuar', style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 30), // Añadimos más espacio
              ],
            ),
          ),
        ),
      ),
    );
  }
}
