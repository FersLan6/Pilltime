import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/nota_model.dart';

class DatabaseNotas {
  static final DatabaseNotas instance = DatabaseNotas._init();
  static Database? _database;

  DatabaseNotas._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notas.db');
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
      CREATE TABLE notas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        contenido TEXT NOT NULL,
        fecha TEXT NOT NULL
      )
    ''');
  }

  // Insertar nota
  Future<int> insertNota(Nota nota) async {
    final db = await instance.database;
    return await db.insert('notas', nota.toMap());
  }

  // Obtener todas las notas
  Future<List<Nota>> getNotas() async {
    final db = await instance.database;
    final result = await db.query('notas');
    return result.map((map) => Nota.fromMap(map)).toList();
  }

  // Actualizar nota
  Future<int> updateNota(Nota nota) async {
    final db = await instance.database;
    return await db.update(
      'notas',
      nota.toMap(),
      where: 'id = ?',
      whereArgs: [nota.id],
    );
  }

  // Eliminar nota
  Future<int> deleteNota(int id) async {
    final db = await instance.database;
    return await db.delete('notas', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
