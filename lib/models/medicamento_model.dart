class Medicamento {
  final int id;
  final String nombre;
  final String dosis;
  final List<bool> dias;
  final List<String> horarios;
  final String? fechaFin;
  final int vecesAlDia;

  Medicamento({
    required this.id,
    required this.nombre,
    required this.dosis,
    required this.dias,
    required this.horarios,
    this.fechaFin,
    required this.vecesAlDia, // Campo requerido
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'dosis': dosis,
      'dias': dias.map((e) => e ? 1 : 0).join(','), // Lista de booleanos a String
      'horarios': horarios.join(','), // Lista de horarios a String
      'fechaFin': fechaFin,
      'vecesAlDia': vecesAlDia, // Incluye este campo
    };
  }

  factory Medicamento.fromMap(Map<String, dynamic> map) {
    return Medicamento(
      id: map['id'],
      nombre: map['nombre'],
      dosis: map['dosis'],
      dias: (map['dias'] as String).split(',').map((e) => e == '1').toList(),
      horarios: (map['horarios'] as String).split(','),
      fechaFin: map['fechaFin'],
      vecesAlDia: map['vecesAlDia'], // Incluye este campo
    );
  }
}
