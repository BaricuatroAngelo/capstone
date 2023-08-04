import 'package:flutter/material.dart';

import '../../pages/Models/resident.dart';

class ResidentCard extends StatelessWidget {
  final Resident resident;
  final VoidCallback onTap;

  const ResidentCard({Key? key, required this.resident, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xff99E9FF),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ]
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 35,
              backgroundColor: Color(0xff99e9ff),
              backgroundImage: AssetImage('asset/doctor.png'),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resident.residentId,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16, // You can adjust the font size as needed
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${resident.residentFName} ${resident.residentLName}',
                    style: const TextStyle(
                      fontSize: 18, // You can adjust the font size as needed
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
