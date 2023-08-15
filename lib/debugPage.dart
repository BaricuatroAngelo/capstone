import 'package:capstone/pages/Models/Patient/EHR.dart';
import 'package:flutter/material.dart';

import 'design/containers/containers.dart';

class ChiefPatientDetailPage extends StatefulWidget {
  final String patientId;
  final String authToken;
  final PatientHealthRecord patient;
  final String roomId;

  const ChiefPatientDetailPage({
    Key? key,
    required this.patient,
    required this.patientId,
    required this.authToken,
    required this.roomId,
  }) : super(key: key);

  @override
  State<ChiefPatientDetailPage> createState() => _ChiefPatientDetailPageState();
}

class _ChiefPatientDetailPageState extends State<ChiefPatientDetailPage> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final centerPosition = screenHeight / 2;

    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: personName,
          ),
          Positioned(
            left: (screenWidth - 300) / 2,
            top: 180,
            child: Container(
              height: 300,
              width: 300,
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
            top: centerPosition - 100,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '${widget.patient.firstName} ${widget.patient.middleName} ${widget.patient.lastName}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Positioned(
            top: centerPosition - 57,
            left: 0,
            right: 0,
            child: SizedBox(
              width: 300,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          height: 50,
                          width: 50,
                          child: Image(
                            image: AssetImage('asset/syringee.png'),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.patient.vaccinationStatus,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    Text(
                      'Age: ${widget.patient.age.toString()}',
                      style: const TextStyle(fontSize: 24),
                    ),
                    Container(
                      height: 50,
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xffFF8A8A).withOpacity(0.4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Text(
                            'Sex: ${widget.patient.sex}',
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: (screenHeight - (-50)) / 2,
            left: 30,
            child: const Text(
              'Doctor Notes',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: (screenWidth - (-700)) / 2,
                top: (screenHeight - (-55)) / 2,
                right: 30),
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xffE3F9FF),
                ),
                child: const Icon(Icons.edit),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 30, right: 30, top: (screenHeight - (-170)) / 2),
            child: Container(
              width: screenWidth,
              height: (screenHeight - 500) / 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xff99E9FF),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ]),
            ),
          ),
          Text(widget.roomId),
        ],
      ),
    );
  }
}
