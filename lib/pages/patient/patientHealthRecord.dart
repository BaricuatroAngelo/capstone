import 'package:capstone/pages/Models/Patient/formCategory.dart';
import 'package:capstone/pages/Models/Patient/patient.dart';
import 'package:capstone/pages/patient/categoryAttributeValues.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../design/containers/widgets/alertDialog.dart';
import '../../design/containers/widgets/urlWidget.dart';
import '../Models/Patient/EHR.dart';

class PatientHealthRecordPage extends StatefulWidget {
  final String authToken;
  final Patient patient;

  const PatientHealthRecordPage(
      {super.key, required this.patient, required this.authToken});

  @override
  State<PatientHealthRecordPage> createState() =>
      PatientHealthRecordPageState();
}

class PatientHealthRecordPageState extends State<PatientHealthRecordPage> {
  List<FormCat> _categories = [];

  Future<void> fetchForm() async {
    final url = Uri.parse('${Env.prefix}/api/formCategories');

    try {
      final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer ${widget.authToken}'
          }
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<FormCat> categoryVal =
        responseData.map((data) => FormCat.fromJson(data)).toList();

        setState(() {
          _categories = categoryVal;
        });
      } else {
        _showSnackBar('Failed to load data!');
      }
    } catch (e) {
      _showSnackBar('An Error Occured. Please try again!');
      print(e);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void navigateToCategoryAttribute(String formCatId) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
        catAttValues(
            authToken: widget.authToken, patient: widget.patient,
            formCatId:formCatId)));
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff66d0ed),
        elevation: 2,
        toolbarHeight: 80,
        title: Padding(
          padding: EdgeInsets.only(left: (screenWidth - 630) / 2),
          child: Text(
            '${widget.patient.patient_id} Patient Health Record',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: FutureBuilder(
        future: fetchForm(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 48,
                crossAxisSpacing: 48,
              ),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    navigateToCategoryAttribute(_categories[index].formCat_id);
                  },
                  child: Card(
                    elevation: 2,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _categories[index].formCat_name,
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              _categories[index].formCat_description,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        )
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
