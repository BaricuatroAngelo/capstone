import 'package:capstone/design/containers/containers.dart';
import 'package:capstone/pages/Models/resident.dart';
import 'package:flutter/material.dart';

import '../../design/containers/widgets/profileInfoWidget.dart';

class ResidentInfoPage extends StatefulWidget {
  final String authToken;
  final String residentId;
  final Resident resident;

  const ResidentInfoPage(
      {super.key,
      required this.residentId,
      required this.authToken,
      required this.resident});

  @override
  ResidentInfoPageState createState() => ResidentInfoPageState();
}

class ResidentInfoPageState extends State<ResidentInfoPage> {
  // Resident? resident;
  // bool _isLoading = true;
  // TextEditingController textControllerResidentFName = TextEditingController();
  // TextEditingController textControllerResidentLName = TextEditingController();
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _fetchResidentDetails();
  // }
  //
  // @override
  // void dispose() {
  //   textControllerResidentFName.dispose();
  //   textControllerResidentLName.dispose();
  //   // Dispose of other text controllers
  //   super.dispose();
  // }
  //
  // Future<void> _updateResidentDetails() async {
  //   final url =
  //   Uri.parse('${Env.prefix}/api/residents/updateResident/${widget.residentId}');
  //   final updatedData = {
  //     'resident_fName': textControllerResidentFName.text,
  //     'resident_lName': textControllerResidentLName.text,
  //     // Add more fields here for other details
  //   };
  //
  //   try {
  //     final response = await http.put(
  //       url,
  //       headers: {
  //         'Authorization': 'Bearer ${widget.authToken}',
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(updatedData),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       _showSnackBar('Resident details updated successfully');
  //     } else {
  //       _showSnackBar('Failed to update resident details');
  //     }
  //   } catch (e) {
  //     _showSnackBar('An error occurred while updating resident details');
  //   }
  // }
  //
  // Future<void> _fetchResidentDetails() async {
  //   final url =
  //       Uri.parse('http://10.0.2.2:8000/api/residents/${widget.residentId}');
  //   try {
  //     final response = await http.get(
  //       url,
  //       headers: {'Authorization': 'Bearer ${widget.authToken}'},
  //     );
  //     if (response.statusCode == 200) {
  //       final responseData = jsonDecode(response.body);
  //       setState(() {
  //         resident = Resident.fromJson(responseData);
  //         _isLoading = false;
  //       });
  //     } else {
  //       _showSnackBar('Failed to fetch patient details');
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   } catch (e) {
  //     _showSnackBar('An error occurred. Please try again later.');
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }
  //
  // void _showSnackBar(String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       duration: const Duration(seconds: 3),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final centerPosition = screenHeight / 2;
    final middleNameInitial = widget.resident.residentMName != 'null' &&
            widget.resident.residentMName.isNotEmpty
        ? '${widget.resident.residentMName[0]}. '
        : '';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff66d0ed),
        elevation: 0.0,
        toolbarHeight: 80,
        title: Padding(
          padding: EdgeInsets.only(left: (screenWidth - 290) / 2),
          child: const Text('Resident Profile'),
        ),
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
            left: (screenWidth - 400) / 2,
            top: 50,
            child: Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xff99E9FF),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Image(
                image: AssetImage('asset/doctor.png'),
              ),
            ),
          ),
          Positioned(
            top: centerPosition - 120,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '${widget.resident.residentFName} $middleNameInitial${widget.resident.residentLName}',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Positioned(
            top: centerPosition - 60,
            left: 0,
            right: 0,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Divider(
                thickness: 3,
              ),
            ),
          ),
          Positioned(
            top: centerPosition - 40,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildProfileInfoTile(
                        'Resident ID', widget.resident.residentId ?? ''),
                    buildProfileInfoTile('Resident First Name',
                        widget.resident.residentFName ?? ''),
                    buildProfileInfoTile('Resident Last Name',
                        widget.resident.residentLName ?? ''),
                    buildProfileInfoTile('Resident Middle Name',
                        widget.resident.residentMName ?? ''),
                    buildProfileInfoTile(
                        'Username', widget.resident.residentUserName ?? ''),
                    buildProfileInfoTile(
                        'Department ID', widget.resident.departmentId ?? ''),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
