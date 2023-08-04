
import 'package:capstone/pages/AddPatient.dart';
import 'package:capstone/pages/Models/Patient/patient.dart';
import 'package:capstone/pages/PatientInfoPage.dart';
import 'package:capstone/pages/ResultsPage.dart';
import 'package:capstone/pages/loginpage.dart';
import 'package:capstone/pages/medicine_page.dart';
import 'package:capstone/testPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
