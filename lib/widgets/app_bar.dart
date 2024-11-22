import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar({
  double logoSize = 30, // Tamaño predeterminado del logo
  Color backgroundColor =
      const Color.fromARGB(255, 76, 94, 175), // Color predeterminado del fondo
}) {
  return AppBar(
    backgroundColor: backgroundColor, // Aplica el color del fondo
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/pilltime.png', // Asegúrate de tener este archivo en assets
          height: logoSize, // Usa el tamaño definido
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
