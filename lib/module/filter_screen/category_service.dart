import 'dart:convert';
import 'dart:developer';
import 'package:activity_app/models/category_model.dart';
import 'package:http/http.dart' as http;
import '../../global/api-key.dart';

class CategoryService {
  static const String apiUrl = 'https://backend.etkinlik.io/api/v2/categories';

  static Future<List<CategoryModel>> getCategories() async {
    try {
      final Uri uri = Uri.parse(apiUrl);
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'X-Etkinlik-Token': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => CategoryModel.fromJson(item)).toList();
      } else {
        throw Exception(
            'API Hatası: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Bağlantı Hatası: $e');
    }
  }
}
