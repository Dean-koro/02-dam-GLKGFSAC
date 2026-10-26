import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recetas.dart';

class RecetasService {
  
  final String apiUrl = 'https://dummyjson.com/recipes';

  Future<List<Receta>> obtenerRecetas() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List recipesJson = data['recipes'];

        return recipesJson.map((json) => Receta.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar las recetas desde la API');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}