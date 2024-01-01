import 'dart:convert';

import 'package:capstone/pages/Models/Patient/patientPhysExamAttributes.dart';
import 'package:capstone/pages/Models/Patient/patientPhysExamCategories.dart';
import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import '../design/containers/widgets/urlWidget.dart';
import 'Models/Patient/patient.dart';
import 'package:http/http.dart' as http;

import 'Models/Patient/patientPhysExamValues.dart';

class PhysExam extends StatefulWidget {
  final String patientId;
  final String authToken;
  final Patient patient;

  const PhysExam(
      {Key? key,
      required this.authToken,
      required this.patient,
      required this.patientId})
      : super(key: key);

  @override
  State<PhysExam> createState() => PhysExamState();
}

class PhysExamState extends State<PhysExam> {
  List<physExamCat> _physExamCat = [];
  List<physExamAtt> _physExamAtt = [];
  List<physExamVal> _physExamVal = [];

  Future<void> _fetchPhysExamCat() async {
    final url = Uri.parse('${Env.prefix}/api/physicalExam/categories');

    try {
      final response = await http
          .get(url, headers: {'Authorization': 'Bearer ${widget.authToken}'});
      print(response.statusCode);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<physExamCat> examCatVal =
            responseData.map((data) => physExamCat.fromJson(data)).toList();

        setState(() {
          _physExamCat = examCatVal;
        });
      } else {
        print('Failed to load data!');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _fetchPhysExamAtt() async {
    final url = Uri.parse('${Env.prefix}/api/physicalExam/attributes');

    try {
      final response = await http
          .get(url, headers: {'Authorization': 'Bearer ${widget.authToken}'});
      print(response.statusCode);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<physExamAtt> examAttVal =
            responseData.map((data) => physExamAtt.fromJson(data)).toList();

        examAttVal.sort((a, b) => a.peaName.compareTo(b.peaName));
        setState(() {
          _physExamAtt = examAttVal;
        });
      } else {
        print('Failed to load data!');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _fetchPhysExamVal() async {
    final url = Uri.parse(
        '${Env.prefix}/api/physicalExam/values/getPEM/${widget.patientId}');

    try {
      final response = await http
          .get(url, headers: {'Authorization': 'Bearer ${widget.authToken}'});
      print(response.statusCode);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<physExamVal> physExVal =
            responseData.map((data) => physExamVal.fromJson(data)).toList();

        setState(() {
          _physExamVal = physExVal;
        });
      } else {
        print('Failed to load data!');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPhysExamAtt();
    _fetchPhysExamVal();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff66d0ed),
        toolbarHeight: 80,
        title: Center(
          child: Text(
            '${widget.patient.patientId} Physical Exam Record',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 8),
        color: const Color(0xff66d0ed),
        width: double.infinity,
        child: ContainedTabBarView(
          tabs: const [
            Text(
              'HEAD',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              'BODY',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              'LEGS',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              'ARMS',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
          views: [
            Scaffold(
              backgroundColor: const Color(0xffE3F9FF),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Container(
                    height: screenHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: FutureBuilder<void>(
                      future: _fetchPhysExamAtt(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Or any loading indicator
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return ListView.builder(
                            itemCount: _physExamAtt.where((att) => att.physExamId == 'PE0').length,
                            itemBuilder: (context, index) {
                              final filteredAttributes = _physExamAtt.where((att) => att.physExamId == 'PE0').toList();
                              final String attNames = filteredAttributes[index].peaName;
                              final List<String> relevantValues = _physExamVal
                                  .where((value) =>
                              value.peaId == filteredAttributes[index].peaId)
                                  .map((value) => value.pavValue)
                                  .toList();
                              return Card(
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: ListTile(
                                  title: Text(
                                    attNames,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            Scaffold(
              backgroundColor: const Color(0xffE3F9FF),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Container(
                    height: screenHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Scaffold(
              backgroundColor: const Color(0xffE3F9FF),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Container(
                    height: screenHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Scaffold(
              backgroundColor: const Color(0xffE3F9FF),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Container(
                    height: screenHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
          onChange: (index) => print(index),
        ),
      ),
    );
  }
}
