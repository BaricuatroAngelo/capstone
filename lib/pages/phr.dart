import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../design/containers/widgets/urlWidget.dart';
import 'Models/Patient/attributeValues.dart';
import 'Models/Patient/categoryAttribute.dart';
import 'Models/Patient/formCategory.dart';
import 'Models/Patient/patient.dart';

class PHRData {
  final String createdAt;
  final FormCat formCat;
  final CategoryAttribute categoryAttribute;
  final AttributeValues attributeValues;

  PHRData({
    required this.createdAt,
    required this.formCat,
    required this.categoryAttribute,
    required this.attributeValues,
  });

  factory PHRData.fromJson(Map<String, dynamic> json) {
    return PHRData(
      createdAt: json['created_at'] ?? '',
      formCat: FormCat.fromJson(json['formCat'] ?? {}),
      categoryAttribute: CategoryAttribute.fromJson(json['categoryAttribute'] ?? {}),
      attributeValues: AttributeValues.fromJson(json['attributeValues'] ?? {}),
    );
  }
}


class PHRScreen extends StatefulWidget {
  final String patientId;
  final String authToken;
  final Patient patient;

  const PHRScreen({super.key, required this.patientId, required this.authToken, required this.patient});

  @override
  _PHRScreenState createState() => _PHRScreenState();
}

class _PHRScreenState extends State<PHRScreen> {
  List<PHRData> _phrData = [];

  Future<void> fetchPHRData() async {
    final url = Uri.parse('${Env.prefix}/attributeValues/getPHRM/${widget.patientId}');
    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${widget.authToken}'
      });
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          _phrData = responseData.map((data) => PHRData.fromJson(data)).toList();
        });
      } else {
        print('Failed to fetch PHR data');
      }
    } catch (e, stackTrace) {
      // Handle exceptions
      print('Exception occurred: $e');
      print('Stack trace: $stackTrace');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPHRData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Health Records'),
      ),
      body: ListView.builder(
        itemCount: _phrData.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_phrData[index].formCat.formCat_name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_phrData[index].categoryAttribute.categoryAtt_name),
                Text(_phrData[index].attributeValues.attributeVal_values),
              ],
            ),
            trailing: Text(_phrData[index].createdAt),
          );
        },
      ),
    );
  }
}
