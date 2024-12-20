class Nota {
  final int? id;
  final String titulo;
  final String contenido;
  final String fecha;

  Nota({
    this.id,
    required this.titulo,
    required this.contenido,
    required this.fecha,
  });

  // Convertir a Map para la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'contenido': contenido,
      'fecha': fecha,
    };
  }

  // Crear desde un Map
  static Nota fromMap(Map<String, dynamic> map) {
    return Nota(
      id: map['id'],
      titulo: map['titulo'],
      contenido: map['contenido'],
      fecha: map['fecha'],
    );
  }
}
