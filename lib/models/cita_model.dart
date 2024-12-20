class Cita {
  final int? id;
  final String lugar;
  final String doctor;
  final String fechaHora;

  Cita({
    this.id,
    required this.lugar,
    required this.doctor,
    required this.fechaHora,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lugar': lugar,
      'doctor': doctor,
      'fechaHora': fechaHora,
    };
  }

  factory Cita.fromMap(Map<String, dynamic> map) {
    return Cita(
      id: map['id'],
      lugar: map['lugar'],
      doctor: map['doctor'],
      fechaHora: map['fechaHora'],
    );
  }
}
