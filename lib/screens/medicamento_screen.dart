import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/bottom_nav_bar.dart';

class MedicamentoScreen extends StatefulWidget {
  const MedicamentoScreen({super.key});

  @override
  State<MedicamentoScreen> createState() => _MedicamentoScreenState();
}

class _MedicamentoScreenState extends State<MedicamentoScreen> {
  List<Map<String, dynamic>> filteredMedicamentos = medicamentos;

  @override
  void initState() {
    super.initState();
    filteredMedicamentos = medicamentos;
  }

  void _filterMedicamentos(String query) {
    setState(() {
      filteredMedicamentos = medicamentos
          .where((med) =>
              med['nombre'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _confirmDeleteMedicamento(int index) {
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
              Text('Confirmar eliminación', style: TextStyle(fontSize: 20)),
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
                  onPressed: () {
                    _deleteMedicamento(index);
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


  void _deleteMedicamento(int index) {
    setState(() {
      medicamentos.removeAt(index);
      filteredMedicamentos = medicamentos;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Medicamento eliminado correctamente.',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal.shade400,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicamentos'),
        backgroundColor: const Color.fromARGB(255, 89, 197, 93), // Color claro para el fondo
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
            // Campo de búsqueda
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
            const SizedBox(height: 8),

            // Lista de medicamentos
            Expanded(
              child: filteredMedicamentos.isEmpty
                  ? const Center(
                      child: Text(
                        'No hay medicamentos guardados.',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                          elevation: 4,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.teal.shade100,
                              child: const Icon(Icons.medical_services_outlined),
                            ),
                            title: Text(
                              med['nombre'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Dosis: ${med['dosis']} - ${med['vecesAlDia']} veces al día',
                              style: const TextStyle(fontSize: 14),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _confirmDeleteMedicamento(index),
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
