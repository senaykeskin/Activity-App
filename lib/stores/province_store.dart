import 'dart:developer';
import 'package:rxdart/rxdart.dart';
import '../models/province_model.dart';
import '../module/filter_screen/provinces_service.dart';
import 'event_store.dart';

class ProvinceStore {
  final BehaviorSubject<List<ProvinceModel>?> provinceList =
      BehaviorSubject<List<ProvinceModel>?>.seeded([]);
  final BehaviorSubject<String?> selectedCity =
      BehaviorSubject<String?>.seeded(null);

  Stream<List<ProvinceModel>?> get provinceListStream => provinceList.stream;
  Stream<String?> get selectedCityStream => selectedCity.stream;

  Future<void> loadProvinces() async {
    try {
      final provinces = await ProvinceService.getProvinces();
      if (provinces == null || provinces.isEmpty) {
        inspect("Şehir listesi boş döndü!");
      }
      provinceList.add(provinces!);
      inspect("Şehirler başarıyla yüklendi: ${provinces.length} adet");
    } catch (e) {
      inspect("Şehir yüklenirken hata oluştu: $e");
      provinceList.sink.add([]);
    }
  }

  void setSelectedCity(String city) {
    selectedCity.add(city);
    eventStore.filterEventsByCity(city);
  }

  void filterEventsByCity(String city) {
    eventStore.filterEventsByCity(city);
  }

  void dispose() {
    provinceList.close();
    selectedCity.close();
  }
}

final provinceStore = ProvinceStore();
