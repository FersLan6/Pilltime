import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class ConfigScreen extends StatefulWidget {
  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  Future<void> shareApp() async {
    try {
      // Ruta del .apk
      final ByteData bytes = await rootBundle.load('assets/apk/pilltime.apk');
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/pilltime.apk');
      await file.writeAsBytes(bytes.buffer.asUint8List());

      // Compartir el archivo
      await Share.shareXFiles(
        [XFile(file.path)],
        text: '¡Descarga la app PillTime!',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al compartir la app: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuración')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: shareApp,
              child: Text('Compartir aplicación'),
            ),
          ],
        ),
      ),
    );
  }
}
