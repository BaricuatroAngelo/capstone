import 'package:capstone/design/containers/containers.dart';
import 'package:flutter/material.dart';
import 'pages/medicine_page.dart'; // Import the MedicineSelectionPage.

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 300,
            width: double.infinity,
            color: const Color(0xff99E9FF),
            child: const Padding(
              padding: EdgeInsets.only(left: 30, top: 230),
              child: Text(
                'Patient Name',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ),

          patientPhoto,
        ],
      ),
    );
  }
}
