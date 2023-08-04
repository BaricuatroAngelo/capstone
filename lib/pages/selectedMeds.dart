import 'package:capstone/design/containers/containers.dart';
import 'package:capstone/design/containers/text.dart';
import 'package:capstone/pages/medicine_page.dart';
import 'package:flutter/material.dart';

import 'Models/medicine.dart';

class SelectedMeds extends StatefulWidget {
  final String patientId;
  const SelectedMeds({super.key, required this.patientId});

  @override
  SelectedMedsState createState() => SelectedMedsState();
}

class SelectedMedsState extends State<SelectedMeds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE3F9FF),
      appBar: AppBar(
        title: const Text('Selected Medicines'),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(
            top: 10,
            left: 20,
            child: titleText,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Container(
              height: 650,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 700, right: 20, left: 20),
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MedicineSelectionPage()));
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Text(
                      'Add Medicine',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
