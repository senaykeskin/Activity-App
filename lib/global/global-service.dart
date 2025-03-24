import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/activity_model.dart';
import 'apiKey.dart';

class ActivityService {
  static const String apiUrl = 'https://backend.etkinlik.io/api/v2/events';

  static Future<List<EventItem>> getEvents(
      {required int skip, required int take}) async {
    try {
      final Uri uri = Uri.parse('$apiUrl?skip=$skip&take=$take');
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'X-Etkinlik-Token': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> items = data['items'];
        return items.map((item) => EventItem.fromJson(item)).toList();
      } else {
        throw Exception(
            'API Hatası: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Bağlantı Hatası: $e');
    }
  }
}
