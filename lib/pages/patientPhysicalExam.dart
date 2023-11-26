import 'dart:convert';

import 'package:capstone/design/containers/containers.dart';
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

        examAttVal.sort((a,b) => a.peaName.compareTo(b.peaName));
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
    final url = Uri.parse('${Env.prefix}/api/physicalExam/values/${widget.patientId}');

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
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff66d0ed),
        toolbarHeight: 80,
        title: Padding(
          padding: EdgeInsets.only(left: (screenWidth - 630) / 2),
          child: Text(
            '${widget.patient.patient_id} Physical Exam Record',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 8),
        color: Color(0xff66d0ed),
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
              body: FutureBuilder(
                future: _fetchPhysExamAtt(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Stack(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: (screenHeight - (650)) / 2),
                          child: Container(
                            width: double.infinity,
                            decoration: physExContainer,
                            child: Container(
                              child: ListView.builder(
                                itemCount: _physExamAtt.length,
                                itemBuilder: (context, index) {
                                  final physExamAtt item = _physExamAtt[index];

                                  // Find the associated physExamVal item
                                  final physExamVal? correspondingVal = _physExamVal.firstWhere(
                                        (val) => val.peaId == item.peaId,
                                    orElse: () => physExamVal(peaId: '', pavValue: 'None', pavId: '', patient_id: ''),
                                  );

                                  if (item.physExamId == 'PE0') {
                                    String valueToShow = 'No Value'; // Default value if no corresponding value found

                                    if (correspondingVal != null) {
                                      // Check if pavValue is a string or integer and set the value to show accordingly
                                      if (correspondingVal.pavValue is String) {
                                        valueToShow = correspondingVal.pavValue as String;
                                      } else if (correspondingVal.pavValue is int) {
                                        valueToShow = (correspondingVal.pavValue as int).toString();
                                      }
                                    }

                                    return ListTile(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        side: BorderSide(color: Colors.grey.shade300, width: 1),
                                      ),
                                      tileColor: Colors.white,
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.blueAccent,
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                      ),
                                      title: Text(
                                        item.peaName,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      trailing: Text(
                                        valueToShow,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      onTap: () {
                                        // Add functionality here when the ListTile is tapped
                                      },
                                    );
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            Scaffold(
              backgroundColor: const Color(0xffE3F9FF),
              body: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: (screenHeight - (650)) / 2),
                    child: Container(
                      width: double.infinity,
                      decoration: homeContainer,
                    ),
                  ),
                ],
              ),
            ),
            Scaffold(
              backgroundColor: const Color(0xffE3F9FF),
              body: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: (screenHeight - (650)) / 2),
                    child: Container(
                      width: double.infinity,
                      decoration: homeContainer,
                    ),
                  ),
                ],
              ),
            ),
            Scaffold(
              backgroundColor: const Color(0xffE3F9FF),
              body: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: (screenHeight - (650)) / 2),
                    child: Container(
                      width: double.infinity,
                      decoration: homeContainer,
                    ),
                  ),
                ],
              ),
            ),
          ],
          onChange: (index) => print(index),
        ),
      ),
    );
  }
}
