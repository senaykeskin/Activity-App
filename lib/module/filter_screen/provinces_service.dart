import 'dart:convert';
import 'dart:developer';
import '../../models/province_model.dart';
import 'package:http/http.dart' as http;

class ProvinceService {
  static const provinceApiUrl = "https://turkiyeapi.dev/api/v1/provinces";

  static Future<List<ProvinceModel>?> getProvinces() async {
    try {
      final Uri uri = Uri.parse(provinceApiUrl);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        ProvinceModel provinceModel = ProvinceModel.fromJson(jsonResponse);
        List<ProvinceModel> items = [provinceModel];

        return items;
      } else {
        throw Exception(
            'API Hatası: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      inspect(e);
      return null;
    }
  }
}
