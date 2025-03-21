class ProvinceModel {
  final String status;
  final List<ProvinceData> data;

  ProvinceModel({required this.status, required this.data});

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
      status: json['status'] as String,
      data:
          (json['data'] as List).map((e) => ProvinceData.fromJson(e)).toList(),
    );
  }
}

class ProvinceData {
  final int id;
  final String name;
  final int population;
  final int area;
  final int altitude;
  final List<int> areaCode;
  final bool isCoastal;
  final bool isMetropolitan;
  final Nuts nuts;
  final Coordinates coordinates;
  final Maps maps;
  final Region region;
  final List<District> districts;

  ProvinceData({
    required this.id,
    required this.name,
    required this.population,
    required this.area,
    required this.altitude,
    required this.areaCode,
    required this.isCoastal,
    required this.isMetropolitan,
    required this.nuts,
    required this.coordinates,
    required this.maps,
    required this.region,
    required this.districts,
  });

  factory ProvinceData.fromJson(Map<String, dynamic> json) {
    return ProvinceData(
      id: json['id'] as int,
      name: json['name'] as String,
      population: json['population'] as int,
      area: json['area'] as int,
      altitude: json['altitude'] as int,
      areaCode: List<int>.from(json['areaCode']),
      isCoastal: json['isCoastal'] as bool,
      isMetropolitan: json['isMetropolitan'] as bool,
      nuts: Nuts.fromJson(json['nuts']),
      coordinates: Coordinates.fromJson(json['coordinates']),
      maps: Maps.fromJson(json['maps']),
      region: Region.fromJson(json['region']),
      districts:
          (json['districts'] as List).map((e) => District.fromJson(e)).toList(),
    );
  }
}

class Nuts {
  final NutsLevel1 nuts1;
  final NutsLevel2 nuts2;
  final String nuts3;

  Nuts({required this.nuts1, required this.nuts2, required this.nuts3});

  factory Nuts.fromJson(Map<String, dynamic> json) {
    return Nuts(
      nuts1: NutsLevel1.fromJson(json['nuts1']),
      nuts2: NutsLevel2.fromJson(json['nuts2']),
      nuts3: json['nuts3'] as String,
    );
  }
}

class NutsLevel1 {
  final String code;
  final Map<String, String> name;

  NutsLevel1({required this.code, required this.name});

  factory NutsLevel1.fromJson(Map<String, dynamic> json) {
    return NutsLevel1(
      code: json['code'] as String,
      name: Map<String, String>.from(json['name']),
    );
  }
}

class NutsLevel2 {
  final String code;
  final String name;

  NutsLevel2({required this.code, required this.name});

  factory NutsLevel2.fromJson(Map<String, dynamic> json) {
    return NutsLevel2(
      code: json['code'] as String,
      name: json['name'] as String,
    );
  }
}

class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates({required this.latitude, required this.longitude});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}

class Maps {
  final String googleMaps;
  final String openStreetMap;

  Maps({required this.googleMaps, required this.openStreetMap});

  factory Maps.fromJson(Map<String, dynamic> json) {
    return Maps(
      googleMaps: json['googleMaps'] as String,
      openStreetMap: json['openStreetMap'] as String,
    );
  }
}

class Region {
  final String en;
  final String tr;

  Region({required this.en, required this.tr});

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      en: json['en'] as String,
      tr: json['tr'] as String,
    );
  }
}

class District {
  final int id;
  final String name;
  final int population;
  final int area;

  District({
    required this.id,
    required this.name,
    required this.population,
    required this.area,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'] as int,
      name: json['name'] as String,
      population: json['population'] as int,
      area: json['area'] as int,
    );
  }
}
