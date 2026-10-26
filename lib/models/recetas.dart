class Receta {
  final int id;
  final String nombre;
  final List<String> ingredientes;
  final List<String> instrucciones;
  final int tiempoPreparacionMinutos;
  final int tiempoCoccionMinutos;
  final int porciones;
  final String dificultad;
  final String cocina;
  final int caloriasPorPorcion;
  final List<String> etiquetas;
  final int usuarioId;
  final String imagenUrl;
  final double calificacion;
  final int cantidadResenas;
  final List<String> tipoComida;
  bool esFavorito; // Propiedad añadida para los favoritos

  Receta({
    required this.id,
    required this.nombre,
    required this.ingredientes,
    required this.instrucciones,
    required this.tiempoPreparacionMinutos,
    required this.tiempoCoccionMinutos,
    required this.porciones,
    required this.dificultad,
    required this.cocina,
    required this.caloriasPorPorcion,
    required this.etiquetas,
    required this.usuarioId,
    required this.imagenUrl,
    required this.calificacion,
    required this.cantidadResenas,
    required this.tipoComida,
    this.esFavorito = false,
  });

  factory Receta.fromJson(Map<String, dynamic> json) {
    return Receta(
      id: (json['id'] as num).toInt(),
      nombre: json['name'] as String,
      ingredientes: List<String>.from(json['ingredients'] as List),
      instrucciones: List<String>.from(json['instructions'] as List),
      tiempoPreparacionMinutos: (json['prepTimeMinutes'] as num).toInt(),
      tiempoCoccionMinutos: (json['cookTimeMinutes'] as num).toInt(),
      porciones: (json['servings'] as num).toInt(),
      dificultad: json['difficulty'] as String,
      cocina: json['cuisine'] as String,
      caloriasPorPorcion: (json['caloriesPerServing'] as num).toInt(),
      etiquetas: List<String>.from(json['tags'] as List),
      usuarioId: (json['userId'] as num).toInt(),
      imagenUrl: json['image'] as String,
      calificacion: (json['rating'] as num).toDouble(),
      cantidadResenas: (json['reviewCount'] as num).toInt(),
      tipoComida: List<String>.from(json['mealType'] as List),
      esFavorito: json['esFavorito'] ?? false,
    );
  }
}