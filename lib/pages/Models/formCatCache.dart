import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static const _keyPrefix = 'myAppCache_';
  final SharedPreferences _prefs;

  CacheManager(this._prefs);

  Future<List<Map<String, dynamic>>> getCachedCategories() async {
    final cachedData = _prefs.getString('${_keyPrefix}formCategories');
    if (cachedData != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(cachedData));
    }
    return [];
  }

  Future<void> cacheCategories(List<Map<String, dynamic>> categories) async {
    await _prefs.setString('${_keyPrefix}formCategories', jsonEncode(categories));
  }
}
