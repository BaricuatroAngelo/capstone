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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickFile,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                primary: const Color(0xff66d0ed),
              ),
              child: const Text('Select File'),
            ),
            const SizedBox(height: 20),
            _selectedFile != null
                ? Text('Selected File: ${basename(_selectedFile!.path)}')
                : const SizedBox.shrink(),
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
