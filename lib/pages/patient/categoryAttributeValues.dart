import 'dart:async';

import 'package:capstone/pages/Models/Patient/attributeValues.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../design/containers/widgets/urlWidget.dart';
import '../Models/Patient/categoryAttribute.dart';
import '../Models/Patient/patient.dart';
import 'dart:convert';

class catAttValues extends StatefulWidget {
  final String authToken;
  final Patient patient;
  final String formCatId;

  const catAttValues({
    super.key,
    required this.authToken,
    required this.patient,
    required this.formCatId,
  });

  @override
  State<catAttValues> createState() => catAttValuesState();
}

class catAttValuesState extends State<catAttValues> {
  List<CategoryAttribute> _attributes = [];
  List<AttributeValues> _attributeValues = [];
  final bool _isLoading = false;
  bool _dataFetched = false;
  late Timer _timer;

  Future<void> fetchAttValues() async {
    final url = Uri.parse(
        '${Env.prefix}/api/attributeValues/getPHRM/${widget.patient.patientId}');
    try {
      final response = await http.get(url,
          headers: {'Authorization': 'Bearer ${widget.authToken}'});
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<AttributeValues> attVals =
        responseData.map((data) => AttributeValues.fromJson(data)).toList();

        setState(() {
          _attributeValues = attVals;
          _dataFetched = true;
        });
        printAttributeValues();
      }
    } catch (e) {
      print(e);
    }
  }

  void printAttributeValues() {
    print('Attribute Values:');
    _attributeValues.forEach((attributeValue) {
      print(attributeValue.attributeVal_values); // Assuming 'value' is the property you want to print
    });
  }

  Future<void> fetchCatAtt() async {
    final url = Uri.parse('${Env.prefix}/api/categoryAttributes');
    try {
      final response = await http.get(url,
          headers: {'Authorization': 'Bearer ${widget.authToken}'});
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<CategoryAttribute> catAtt =
        responseData.map((data) => CategoryAttribute.fromJson(data)).toList();
        final List<CategoryAttribute> filteredCatAtt =
        catAtt.where((value) => value.formCat_id == widget.formCatId).toList();
        setState(() {
          _attributes = filteredCatAtt;
          _dataFetched = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  void initState() {
    super.initState();
    fetchCatAtt();
    // Start fetching attribute values every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      fetchAttValues();
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  String modifyAttributeName(String attributeName) {
    if (attributeName.startsWith('phr_')) {
      // Remove the prefix "phr_" and capitalize the character after that
      attributeName = attributeName.replaceFirst('phr_', '');
      attributeName = attributeName.replaceRange(
          0, 1, attributeName.substring(0, 1).toUpperCase());
    }

    // Add white spaces before capitalized letters
    attributeName = attributeName.replaceAllMapped(
        RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}');

    return attributeName;
  }

  Widget buildListView() {
    if (!_dataFetched) {
      return const Center(child: CircularProgressIndicator());
    }

    final List<Widget> listItems = [];

    for (var attribute in _attributes) {
      String attributeName = attribute.categoryAtt_returnName;

      final attributeValue = _attributeValues.firstWhere(
        (value) => value.categoryAtt_id == attribute.categoryAtt_id,
        orElse: () => AttributeValues(
          attributeVal_values: 'N/A',
          attributeVal_id: '',
          patientId: '',
          categoryAtt_id: '',
        ),
      );

      if (attribute.categoryAtt_dataType == 'boolean' &&
          attributeValue.attributeVal_values == '0') {
        continue; // Skip this attribute if the value is 0 and it's boolean
      }

      var displayValue = attributeValue.attributeVal_values;
      if (attribute.categoryAtt_dataType == 'boolean') {
        displayValue = displayValue == '1' ? 'Present' : 'Absent';
      }

      listItems.add(
        Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: ListTile(
            title: Text(
              attributeName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              overflow: TextOverflow.visible,
            ),
            trailing: Text(
              displayValue,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 24,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );
    }

    return ListView(
      children: listItems,
    );
  }


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff66d0ed),
        elevation: 2,
        toolbarHeight: 80,
        title: Padding(
          padding: EdgeInsets.only(left: (screenWidth - 200) / 2),
          child: Text(
            widget.formCatId,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {},
          ),
        ],
      ),
      body: buildListView(),
    );
  }
}
