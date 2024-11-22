import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar() {
  return AppBar(
    backgroundColor: Colors.green[600], // Fondo verde llamativo
    title: Row(
      children: [
        Image.asset(
          'assets/pilltime.png', // Ruta de tu logo
          height: 30,
        ),
        const SizedBox(width: 10),
        const Text(
          'PillTime',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    centerTitle: true,
  );
}
