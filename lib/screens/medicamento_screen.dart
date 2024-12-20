import 'package:flutter/material.dart';
import '../helpers/database_helper.dart'; // Importa la base de datos
import '../models/medicamento_model.dart'; // Importa el modelo de medicamento
import '../widgets/bottom_nav_bar.dart';
import 'edit_medication_page.dart'; // Importa la pantalla de edición

class MedicamentoScreen extends StatefulWidget {
  const MedicamentoScreen({super.key});

  @override
  State<MedicamentoScreen> createState() => _MedicamentoScreenState();
}

class _MedicamentoScreenState extends State<MedicamentoScreen> {
  List<Medicamento> medicamentos = [];
  List<Medicamento> filteredMedicamentos = [];

  @override
  void initState() {
    super.initState();
    _loadMedicamentos(); // Carga los medicamentos al iniciar
  }

  Future<void> _loadMedicamentos() async {
    final loadedMedicamentos = await DatabaseHelper.instance.getMedicamentos();
    setState(() {
      medicamentos = loadedMedicamentos;
      filteredMedicamentos = loadedMedicamentos;
    });
  }

  void _filterMedicamentos(String query) {
    setState(() {
      filteredMedicamentos = medicamentos
          .where(
              (med) => med.nombre.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _confirmEditMedicamento(Medicamento medicamento) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: const [
              Icon(Icons.edit, color: Colors.blue, size: 28),
              SizedBox(width: 8),
              Text(
                'Confirmar edición',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Text(
            '¿Estás seguro de que deseas editar este medicamento?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cierra el diálogo
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('No', style: TextStyle(fontSize: 16)),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop(); // Cierra el diálogo
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditMedicationPage(
                          medicamento: medicamento,
                        ),
                      ),
                    );
                    if (result == true) {
                      _loadMedicamentos(); // Recarga la lista si hubo cambios
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Sí', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteMedicamento(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
              SizedBox(width: 8),
              Text('Confirmar eliminación',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          content: const Text(
            '¿Estás seguro de que deseas eliminar este medicamento?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cerrar el diálogo
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('No', style: TextStyle(fontSize: 16)),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await DatabaseHelper.instance.deleteMedicamento(id);
                    _loadMedicamentos(); // Recarga los medicamentos
                    Navigator.of(context).pop(); // Cerrar el diálogo
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Sí', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Medicamentos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: _filterMedicamentos,
                decoration: InputDecoration(
                  labelText: 'Buscar medicamento',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Expanded(
              child: filteredMedicamentos.isEmpty
                  ? const Center(
                      child: Text(
                        'No hay medicamentos guardados.',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredMedicamentos.length,
                      itemBuilder: (context, index) {
                        final med = filteredMedicamentos[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.teal.shade100,
                              child:
                                  const Icon(Icons.medical_services_outlined),
                            ),
                            title: Text(
                              med.nombre,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                'Dosis: ${med.dosis} - Horarios: ${med.horarios.join(', ')}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () =>
                                      _confirmEditMedicamento(med),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () =>
                                      _confirmDeleteMedicamento(med.id!),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 1),
    );
  }
}
