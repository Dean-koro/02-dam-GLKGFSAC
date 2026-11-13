class Resena {
  final int recetaId;
  final String autor;
  final int calificacion; // de 1 a 5 estrellas
  final String comentario;
  final DateTime fecha;

  Resena({
    required this.recetaId,
    required this.autor,
    required this.calificacion,
    required this.comentario,
    DateTime? fecha,
  }) : fecha = fecha ?? DateTime.now();
}
