import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import '../design/containers/widgets/urlWidget.dart';
import 'Models/Patient/EHR.dart';

class FileUploadPage extends StatefulWidget {
  final String authToken;
  final String residentId;
  final String patientId;

  FileUploadPage(
      {super.key,
      required this.authToken,
      required this.residentId,
      required this.patientId});

  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  File? _selectedFile;
  late List<String> uploadedFiles = [];

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _uploadFile() async {
    if (_selectedFile != null) {
      final url = Uri.parse(
          '${Env.prefix}/api/fileUpload'); // Replace with your API URL
      final request = http.MultipartRequest('POST', url);

      request.headers['Authorization'] = 'Bearer ${widget.authToken}';

      request.fields['resident_id'] = widget.residentId;
      request.fields['patient_id'] = widget.patientId;

      request.files.add(http.MultipartFile(
        'file',
        _selectedFile!.readAsBytes().asStream(),
        _selectedFile!.lengthSync(),
        filename: basename(_selectedFile!.path),
      ));

      try {
        final response = await request.send();
        print(response.statusCode);
        print(response.stream.bytesToString());
        if (response.statusCode == 200) {
          print('upload success');
        } else {
          print('failed to upload file');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> fetchUploadedFiles() async {
    try {
      final url = Uri.parse('${Env.prefix}/api/fileUpload');
      final response = await http.get(
        url.replace(queryParameters: {
          'residentId': widget.residentId,
          'patientId': widget.patientId,
        }),
        headers: {
          'Authorization': 'Bearer ${widget.authToken}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> files = json.decode(response.body);
        if (files is List<dynamic>) {
          setState(() {
            uploadedFiles = files.map((file) => file['file_name'].toString()).toList();
          });
        } else {
          print('Invalid data format received');
        }
      } else {
        print('Failed to fetch files: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching files: $e');
    }
  }



  @override
  void initState() {
    super.initState();
    // Fetch uploaded files on page load
    fetchUploadedFiles();
  }

  Widget _buildUploadedFilesGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns in the grid
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: uploadedFiles.length,
      itemBuilder: (context, index) {
        final fileName = uploadedFiles[index];
        final fileExtension = fileName.split('.').last.toLowerCase();

        // Determine the icon based on the file extension
        IconData iconData;
        if (fileExtension == 'jpg' || fileExtension == 'png') {
          iconData = Icons.image;
        } else {
          iconData = Icons.description;
        }

        return GestureDetector(
          onTap: () {
            // Handle what happens when a file is tapped
            // For example, open the file or view details
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  size: 40, // Adjust the icon size as needed
                ),
                SizedBox(height: 8),
                Text(
                  fileName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16), // Adjust font size if needed
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff66d0ed),
        elevation: 2,
        toolbarHeight: 80,
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 50),
            child: Text(
              'File Upload',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'pick') {
                _pickFile();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'pick',
                child: ListTile(
                  leading: Icon(Icons.attach_file),
                  title: Text('Select File'),
                ),
              ),
              // Add more options if needed
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            _selectedFile != null
                ? Text('Selected File: ${basename(_selectedFile!.path)}')
                : const SizedBox.shrink(),
            const SizedBox(height: 20,),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: _buildUploadedFilesGrid(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadFile,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                primary: const Color(0xff66d0ed),
              ),
              child: const Text('Upload File'),
            ),
          ],
        ),
      ),
    );
  }
}
