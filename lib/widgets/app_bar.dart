import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar() {
  return AppBar(
    title: Row(
      children: [
        Image.asset(
          'assets/pilltime.png', // Reemplaza con la ruta de tu logo
          height: 30,
        ),
        const SizedBox(width: 8),
        const Text(
          'PillTime',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
    centerTitle: true,
  );
}
