import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/cita_model.dart';

class DatabaseCitas {
  static final DatabaseCitas instance = DatabaseCitas._init();
  static Database? _database;

  DatabaseCitas._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('citas.db');
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

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE citas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        lugar TEXT NOT NULL,
        doctor TEXT NOT NULL,
        fechaHora TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertCita(Cita cita) async {
    final db = await instance.database;
    return await db.insert('citas', cita.toMap());
  }

  Future<int> updateCita(Cita cita) async {
    final db = await instance.database;
    return await db.update(
      'citas',
      cita.toMap(),
      where: 'id = ?',
      whereArgs: [cita.id],
    );
  }

  Future<List<Cita>> getCitas() async {
    final db = await instance.database;
    final result = await db.query('citas');
    return result.map((map) => Cita.fromMap(map)).toList();
  }

  Future<int> deleteCita(int id) async {
    final db = await instance.database;
    return await db.delete('citas', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
