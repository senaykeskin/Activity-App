import 'dart:convert';
import 'package:http/http.dart' as http;

class ActivityService {
  static const String apiUrl = 'https://backend.etkinlik.io/api/v2/events';

  static Future<Map<String, dynamic>> getEvents({
    String categoryIds = '',
    int skip = 0,
    int take = 30,
  }) async {
    try {
      final Uri uri = Uri.parse('$apiUrl&take=$take');
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'X-Etkinlik-Token': apiKey,
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('API Hatası: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Bağlantı Hatası: $e');
    }
  }
}
