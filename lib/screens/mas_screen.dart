import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'notas_screen.dart';
import 'citas_screen.dart';
import 'config_screen.dart';

class MasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header: Logo, nombre y ubicación
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            color: Colors.green, // Fondo verde
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/pilltime.png',
                      height: 50, // Tamaño del logo
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Pill Time',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Texto blanco
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Opciones
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                // Botón: Notas
                _buildOption(
                  context: context,
                  iconPath: 'assets/notas.png',
                  title: 'Notas',
                  destination: NotasScreen(), // Pantalla de destino
                ),
                const SizedBox(height: 12),
                // Botón: Citas
                _buildOption(
                  context: context,
                  iconPath: 'assets/citas.png',
                  title: 'Citas',
                  destination: CitasScreen(), // Pantalla de destino
                ),
                const SizedBox(height: 12),
                // Botón: Configuración
                _buildOption(
                  context: context,
                  iconPath: 'assets/config.png',
                  title: 'Configuración',
                  destination: ConfigScreen(), // Pantalla de destino
                ),
              ],
            ),
          ),
          // Barra de navegación
          BottomNavBar(selectedIndex: 2),
        ],
      ),
    );
  }

  // Widget para las opciones con fondo blanco y estilo dinámico
  Widget _buildOption({
    required BuildContext context,
    required String iconPath,
    required String title,
    required Widget destination,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              height: 40,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
