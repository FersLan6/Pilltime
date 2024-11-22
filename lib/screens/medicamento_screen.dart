import 'package:flutter/material.dart';
import '../main.dart'; // Importar lista global

class MedicamentoScreen extends StatelessWidget {
  const MedicamentoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medicamentos')),
      body: medicamentos.isEmpty
          ? const Center(child: Text('No hay medicamentos guardados.'))
          : ListView.builder(
              itemCount: medicamentos.length,
              itemBuilder: (context, index) {
                final med = medicamentos[index];
                return Card(
                  child: ListTile(
                    title: Text(med['nombre']),
                    subtitle: Text(
                      'Dosis: ${med['dosis']} - ${med['vecesAlDia']} veces al día',
                    ),
                  ),
                );
              },
            ),
    );
  }
}
