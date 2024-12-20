import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/medicamento_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pilltime.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE medicamentos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre $textType,
        dosis $textType,
        dias $textType,
        horarios $textType
      )
    ''');
  }

  Future<int> insertMedicamento(Medicamento medicamento) async {
    final db = await instance.database;
    return await db.insert('medicamentos', medicamento.toMap());
  }

  Future<List<Medicamento>> getMedicamentos() async {
    final db = await instance.database;
    final result = await db.query('medicamentos');
    return result.map((map) => Medicamento.fromMap(map)).toList();
  }

  Future<int> deleteMedicamento(int id) async {
    final db = await instance.database;
    return await db.delete('medicamentos', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
