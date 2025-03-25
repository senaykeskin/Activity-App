import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

class FavoritesStore {
  static final FavoritesStore _instance = FavoritesStore._internal();

  factory FavoritesStore() => _instance;

  FavoritesStore._internal() {
    _loadFavorites();
  }

  static const String favoritesKey = 'favoriteEventIds';

  final BehaviorSubject<List<int>> favoriteSubject =
      BehaviorSubject<List<int>>.seeded([]);

  Stream<List<int>> get favoriteList => favoriteSubject.stream;

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(favoritesKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      favoriteSubject.add(jsonList.map((e) => e as int).toList());
    }
  }

  Future<void> addFavorite(int eventId) async {
    final currentFavorites = favoriteSubject.value;
    if (!currentFavorites.contains(eventId)) {
      currentFavorites.add(eventId);
      favoriteSubject.add(List<int>.from(currentFavorites));
      await _saveFavorites(currentFavorites);
    }
  }

  Future<void> removeFavorite(int eventId) async {
    final currentFavorites = favoriteSubject.value;
    currentFavorites.remove(eventId);
    favoriteSubject.add(List<int>.from(currentFavorites));
    await _saveFavorites(currentFavorites);
  }

  Future<void> _saveFavorites(List<int> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(favorites);
    await prefs.setString(favoritesKey, jsonString);
  }
}

final favoritesStore = FavoritesStore();
