import 'package:capstone/design/containers/containers.dart';
import 'package:capstone/pages/medicine_page.dart';
import 'package:flutter/material.dart';

class PatientPage extends StatelessWidget {
  const PatientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          Positioned(
            left: 225,
            top: 210,
            child: Container(
              height: 170,
              width: 170,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff99E9FF),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 330,
            left: 20,
            child: Row(
              children: [
                resultsPage, // Make sure 'resultsPage' is defined and imported correctly
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MedicineSelectionPage()));
                  },
                  child: const Text('NAVIGATE PLEASE'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
