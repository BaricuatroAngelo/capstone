import 'package:flutter/material.dart';

import '../../../pages/Models/Patient/patient.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  final VoidCallback onTap;

  const PatientCard({Key? key, required this.patient, required this.onTap})
      : super(key: key);

  @override
  double _calculateContainerHeight(BuildContext context) {
    // Get the screen height
    final screenHeight = MediaQuery.of(context).size.height;

    // Define your desired height range based on the screen height
    // You can adjust the values as per your preference
    if (screenHeight < 600) {
      // Small phones
      return 150;
    } else if (screenHeight < 1000) {
      // Medium-sized phones and small tablets
      return 200;
    } else {
      // Larger tablets and devices
      return 200;
    }
  }

  double _calculateContainerWidth(BuildContext context) {
    // Get the screen height
    final screenWidth = MediaQuery.of(context).size.height;

    // Define your desired height range based on the screen height
    // You can adjust the values as per your preference
    if (screenWidth < 600) {
      // Small phones
      return 150;
    } else if (screenWidth < 1000) {
      // Medium-sized phones and small tablets
      return 200;
    } else {
      // Larger tablets and devices
      return 200;
    }
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 10),
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: _calculateContainerHeight(context),
              width: _calculateContainerWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xff99e9ff),
              ),
              child: const Image(
                image: AssetImage('asset/doctor.png'),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patient.patientId,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30, // You can adjust the font size as needed
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${patient.patient_fName} ${patient.patient_lName}',
                        style: const TextStyle(
                          fontSize: 24, // You can adjust the font size as needed
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Row(
                        children: [
                          Text(
                            patient.patient_sex,
                            style: const TextStyle(
                              fontSize:
                              24, // You can adjust the font size as needed
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            patient.patient_age.toString(),
                            style: const TextStyle(
                              fontSize:
                              24, // You can adjust the font size as needed
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
