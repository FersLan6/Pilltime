import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_ES', null);
  runApp(const PillTimeApp());
}

class PillTimeApp extends StatelessWidget {
  const PillTimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PillTime',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomeScreen(),
    );
  }
}
