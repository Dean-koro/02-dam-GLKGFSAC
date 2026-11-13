import '../models/resena.dart';

class ResenasService {
  // Las reseñas se guardan en memoria mientras la app está abierta.
  // Es "static" para que todas las pantallas compartan la misma lista.
  static final Map<int, List<Resena>> _resenasPorReceta = {};

  List<Resena> obtenerResenas(int recetaId) {
    return List.unmodifiable(_resenasPorReceta[recetaId] ?? []);
  }

  void agregarResena(Resena resena) {
    // insert(0, ...) para que la más reciente salga primero
    _resenasPorReceta.putIfAbsent(resena.recetaId, () => []).insert(0, resena);
  }
}
