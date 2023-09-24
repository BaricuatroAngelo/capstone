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

  Future<void> fetchAttValues() async {
    final url = Uri.parse('${Env.prefix}/api/attributeValues');

    try {
      final response = await http
          .get(url, headers: {'Authorization': 'Bearer ${widget.authToken}'});
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<AttributeValues> attVals =
            responseData.map((data) => AttributeValues.fromJson(data)).toList();

        setState(() {
          _attributeValues = attVals;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchCatAtt() async {
    final url = Uri.parse('${Env.prefix}/api/categoryAttributes');

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${widget.authToken}',
      });
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<CategoryAttribute> catAtt = responseData
            .map((data) => CategoryAttribute.fromJson(data))
            .toList();
        setState(() {
          _attributes = catAtt;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  List<String> getCategoryAttributeNames(String formCatId) {
    return _attributes
        .where((attribute) => attribute.formCat_id == formCatId)
        .map((attribute) => attribute.categoryAtt_name)
        .toList();
  }


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final List<String> attributeNames =
        getCategoryAttributeNames(widget.formCatId);

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
        ),
        body: FutureBuilder(
          future: fetchCatAtt(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: _attributes.length,
                itemBuilder: (context, index) {
                  if (_attributes[index].formCat_id == widget.formCatId) {
                    return ListTile(
                      title: Text(_attributes[index].categoryAtt_name),
                    );
                  } else {
                    return SizedBox.shrink(); // Hide irrelevant items
                  }
                },
              );
            }
          },
        ));
  }
}
