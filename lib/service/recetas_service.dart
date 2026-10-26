import 'dart:convert';

import 'package:app_gastro_v1/models/recetas.dart';
import 'package:http/http.dart' as http;

class RecetaService {
  static const String _baseUrl = 'https://dummyjson.com/recipes';

  Future<List<Receta>> obtenerRecetas() async {
    final Uri url = Uri.parse(_baseUrl);
    final http.Response respuesta = await http.get(url);

    if (respuesta.statusCode != 200) {
      throw Exception(
        'Error al obtener las recetas (${respuesta.statusCode})',
      );
    }

    final Map<String, dynamic> data =
        jsonDecode(respuesta.body) as Map<String, dynamic>;
    final List<dynamic> recetasJson = data['recipes'] as List<dynamic>;

    return recetasJson
        .map(
          (recetaJson) => Receta.fromJson(
            recetaJson as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}
