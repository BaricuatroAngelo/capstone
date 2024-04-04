import 'dart:async';
import 'dart:convert';

import 'package:capstone/pages/Models/Patient/patientPhysExamAttributes.dart';
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
  List<physExamAtt> _physExamAtt = [];
  List<physExamVal> _physExamVal = [];
  bool _dataFetched = false;
  late Timer _timer;

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
          _dataFetched = true;
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
          _dataFetched = true;
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

    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _fetchPhysExamVal();
    });
  }

  Widget buildListView(String categoryId) {
    if (!_dataFetched) {
      return const Center(child: CircularProgressIndicator());
    } else if (_physExamAtt.isEmpty) {
      return const Center(child: Text('No data available'));
    } else {
      return ListView.builder(
        itemCount: _physExamAtt.where((att) => att.physExamId == categoryId && att.peaName.toLowerCase().contains('specify')).length,
        itemBuilder: (context, index) {
          final filteredAttributes = _physExamAtt.where((att) => att.physExamId == categoryId && att.peaName.toLowerCase().contains('specify')).toList();
          final attribute = filteredAttributes[index];

          // Get the attribute name
          final attributeName = attribute.returnName;

          final List<String> relevantValues = _physExamVal
              .where((value) => value.peaId == attribute.peaId)
              .map((value) {
            final pavValue = value.pavValue;
            return pavValue;
          })
              .toList();
          return GestureDetector(
            onTap: () {
              _showDetailsDialog(attributeName, relevantValues);
            },
            child: Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(
                  attributeName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                // Display relevant values here based on your requirement
              ),
            ),
          );
        },
      );
    }
  }


  void _showDetailsDialog(String attributeName, List<String> attributeValues) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(attributeName),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8, // Limiting the width
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: attributeValues.map(
                      (value) => Text(
                    value,
                    style: const TextStyle(color: Colors.black54, fontSize: 24),
                  ),
                ).toList(),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }



  @override
  void dispose() {
    super.dispose();

    _timer.cancel();
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
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 300),
                      child: Container(
                        height: screenHeight,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: buildListView('PE0'),
                      ),
                    ),
                    Positioned(
                      top: 40, // Adjust the position of the avatar as needed
                      left: screenWidth / 2 - 120, // Adjust left position based on the screen width and avatar size
                      child: CircleAvatar(
                        radius: 120,
                        backgroundColor: Colors.white,
                        child: Center(
                          child: Image.asset(
                            'asset/person.png', // Replace with your image path
                            width: 180, // Adjust the width of the image
                            height: 180, // Adjust the height of the image
                            fit: BoxFit.cover, // Adjust the fit based on your needs
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Scaffold(
              backgroundColor: const Color(0xffE3F9FF),
              body: Container(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 300),
                      child: Container(
                        height: screenHeight,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: buildListView('PE1'),
                      ),
                    ),
                    Positioned(
                      top: 40, // Adjust the position of the avatar as needed
                      left: screenWidth / 2 - 120, // Adjust left position based on the screen width and avatar size
                      child: CircleAvatar(
                        radius: 120,
                        backgroundColor: Colors.white,
                        child: Center(
                          child: Image.asset(
                            'asset/chest.png', // Replace with your image path
                            width: 180, // Adjust the width of the image
                            height: 180, // Adjust the height of the image
                            fit: BoxFit.cover, // Adjust the fit based on your needs
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Scaffold(
              backgroundColor: const Color(0xffE3F9FF),
              body: Container(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 300),
                      child: Container(
                        height: screenHeight,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: buildListView('PE2'),
                      ),
                    ),
                    Positioned(
                      top: 40, // Adjust the position of the avatar as needed
                      left: screenWidth / 2 - 120, // Adjust left position based on the screen width and avatar size
                      child: CircleAvatar(
                        radius: 120,
                        backgroundColor: Colors.white,
                        child: Center(
                          child: Image.asset(
                            'asset/leg.png', // Replace with your image path
                            width: 180, // Adjust the width of the image
                            height: 180, // Adjust the height of the image
                            fit: BoxFit.cover, // Adjust the fit based on your needs
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Scaffold(
              backgroundColor: const Color(0xffE3F9FF),
              body: Container(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 300),
                      child: Container(
                        height: screenHeight,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: buildListView('PE3'),
                      ),
                    ),
                    Positioned(
                      top: 40, // Adjust the position of the avatar as needed
                      left: screenWidth / 2 - 120, // Adjust left position based on the screen width and avatar size
                      child: CircleAvatar(
                        radius: 120,
                        backgroundColor: Colors.white,
                        child: Center(
                          child: Image.asset(
                            'asset/elbow.png', // Replace with your image path
                            width: 180, // Adjust the width of the image
                            height: 180, // Adjust the height of the image
                            fit: BoxFit.cover, // Adjust the fit based on your needs
                          ),
                        ),
                      ),
                    ),
                  ],
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
