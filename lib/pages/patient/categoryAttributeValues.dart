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

  const catAttValues(
      {super.key,
      required this.authToken,
      required this.patient,
      required this.formCatId});

  @override
  State<catAttValues> createState() => catAttValuesState();
}

class catAttValuesState extends State<catAttValues> {
  List<CategoryAttribute> _attributes = [];
  List<AttributeValues> _attributeValues = [];
  final bool _isLoading = false;
  bool _dataFetched = false;

  Future<void> fetchAttValues() async {
    final url = Uri.parse('${Env.prefix}/api/attributeValues/getPHRM/${widget.patient.patientId}');
    try {
      final response = await http.get(url, headers: {'Authorization': 'Bearer ${widget.authToken}'});
      if (mounted && response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<AttributeValues> attVals = responseData.map((data) => AttributeValues.fromJson(data)).toList();
        if (mounted) {
          setState(() {
            _attributeValues = attVals;
            _dataFetched = true;
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchCatAtt() async {
    final url = Uri.parse('${Env.prefix}/api/categoryAttributes');
    try {
      final response = await http.get(url, headers: {'Authorization': 'Bearer ${widget.authToken}'});
      print(response.statusCode);
      if (mounted && response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<CategoryAttribute> catAtt = responseData.map((data) => CategoryAttribute.fromJson(data)).toList();
        final List<CategoryAttribute> filteredCatAtt = catAtt.where((value) => value.formCat_id == widget.formCatId).toList();
        if (mounted) {
          setState(() {
            _attributes = filteredCatAtt;
            _dataFetched = true;
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCatAtt();
    fetchAttValues();
  }

  Widget buildListView() {
    if (!_dataFetched) {
      return const Center(child: CircularProgressIndicator());
    } else if (_attributes.isEmpty) {
      return const Center(child: Text('No data available'));
    } else {
      return ListView.builder(
        itemCount: _attributes.length,
        itemBuilder: (context, index) {
          final String attributeName =
              _attributes[index].categoryAtt_name;
          final List<String> relevantValues = _attributeValues
              .where((value) =>
          value.categoryAtt_id == _attributes[index].formCat_id)
              .map((value) => value.attributeVal_values)
              .toList();

          return Card(
            elevation: 2,
            margin:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                attributeName,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 24),
              ),
              trailing: relevantValues.isNotEmpty
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: relevantValues
                    .map(
                      (value) =>
                      Text(
                        'Attribute Value: $value',
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 24),
                      ),
                )
                    .toList(),
              )
                  : const Text(
                'None',
                style: TextStyle(
                    color: Colors.grey, fontSize: 24),
              ),
            ),
          );
        },
      );
    }
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
            onPressed: () {
            },
          ),
        ],
      ),
      body: buildListView(),
    );
  }
}
