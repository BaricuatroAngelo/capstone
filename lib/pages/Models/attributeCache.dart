import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:capstone/pages/Models/Patient/attributeValues.dart';
import 'package:capstone/pages/Models/Patient/categoryAttribute.dart';


import '../../design/containers/widgets/urlWidget.dart';

class CacheManager {
  static final CacheManager _instance = CacheManager._internal();

  factory CacheManager() {
    return _instance;
  }

  CacheManager._internal();

  List<CategoryAttribute> _cachedAttributes = [];
  List<AttributeValues> _cachedAttributeValues = [];

  List<CategoryAttribute> get cachedAttributes => _cachedAttributes;
  List<AttributeValues> get cachedAttributeValues => _cachedAttributeValues;

  Future<void> fetchAttributes(String authToken) async {
    final url = Uri.parse('${Env.prefix}/api/categoryAttributes');

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $authToken',
      });
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        _cachedAttributes =
            responseData.map((data) => CategoryAttribute.fromJson(data)).toList();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchAttributeValues(String authToken) async {
    final url = Uri.parse('${Env.prefix}/api/attributeValues');

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $authToken',
      });
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        _cachedAttributeValues =
            responseData.map((data) => AttributeValues.fromJson(data)).toList();
      }
    } catch (e) {
      print(e);
    }
  }
}
