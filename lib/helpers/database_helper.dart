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
    await db.execute('''
      CREATE TABLE medicamentos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        dosis TEXT NOT NULL,
        dias TEXT NOT NULL,
        horarios TEXT NOT NULL,
        fechaFin TEXT NOT NULL,
        vecesAlDia INTEGER NOT NULL
      )
    '''
    );
  }

  Future<int> insertMedicamento(Medicamento medicamento) async {
    final db = await instance.database;
    return await db.insert('medicamentos', medicamento.toMap());
  }

  Future<int> updateMedicamento(Medicamento medicamento) async {
    final db = await instance.database;
    return await db.update(
      'medicamentos',
      medicamento.toMap(),
      where: 'id = ?',
      whereArgs: [medicamento.id],
    );
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