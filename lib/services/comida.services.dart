import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/comida.dart';

class ComidaService {
  // Evitar el operador '!' y usar un fallback si no se cargó .env
  final String _baseUrl =
      dotenv.env['COMIDA_URL_API'] ??
      'https://www.themealdb.com/api/json/v1/1/categories.php';

  // Obtiene la lista de categorías/comidas
  Future<List<comida>> fetchComidas() async {
    final uri = Uri.parse('$_baseUrl/categories.php');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        final List<dynamic> categoriesJson =
            body['categories'] as List<dynamic>;
        return categoriesJson
            .map((j) => comida.fromJson(j as Map<String, dynamic>))
            .toList(growable: false);
      } else {
        throw Exception('Error cargando categorías: ${response.statusCode}');
      }
    } catch (e, st) {
      if (kDebugMode) {
        print('fetchComidas error: $e');
        print(st);
      }
      rethrow;
    }
  }

  // Busca una comida por id dentro del endpoint de categories (si la API no tiene endpoint directo)
  Future<comida> getComidaById(String id) async {
    final uri = Uri.parse('$_baseUrl/categories.php');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        final List<dynamic> categoriesJson =
            body['categories'] as List<dynamic>;

        final found = categoriesJson.cast<Map<String, dynamic>>().firstWhere(
          (m) => (m['idCategory'] ?? '').toString() == id,
          orElse: () => throw Exception('Comida con id $id no encontrada'),
        );

        return comida.fromJson(found);
      } else {
        throw Exception('Error cargando detalle: ${response.statusCode}');
      }
    } catch (e, st) {
      if (kDebugMode) {
        print('getComidaById error: $e');
        print(st);
      }
      rethrow;
    }
  }
}
