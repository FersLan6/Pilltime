// screens/mas_screen.dart
import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class MasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Más')),
      body: Center(child: Text('Aquí van las opciones de configuración')),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
