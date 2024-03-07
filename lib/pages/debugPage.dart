import 'dart:convert';
import 'dart:io';
import 'package:capstone/pages/Models/fileUpload.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../design/containers/widgets/urlWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class FileUploadPage extends StatefulWidget {
  final String authToken;
  final String residentId;
  final String patientId;

  const FileUploadPage(
      {Key? key,
      required this.authToken,
      required this.residentId,
      required this.patientId}) : super(key: key);

  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  File? _selectedFile;
  List<FileUpload> uploadedFiles = [];

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

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
          _showSnackBar('upload success');
          await reloadPage();

        } else {
          _showSnackBar('failed to upload file');
          await reloadPage();
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
        final List<dynamic> responseData = json.decode(response.body);
        final List<FileUpload> filesUpload = responseData
            .map((data) => FileUpload.fromJson(data))
            .toList();
        setState(() {
          uploadedFiles = filesUpload;
        });
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

  void _downloadFile(String fileUrl) async {
    try {
      // Using open_file to directly open the file
      final file = File(fileUrl); // Assuming fileUrl contains the absolute file path

      // Check if the file exists before attempting to open it
      if (await file.exists()) {
        await OpenFile.open(fileUrl); // Open the file
      } else {
        throw 'File does not exist: $fileUrl';
      }
    } catch (e) {
      print('Error opening file: $e');
    }
  }

  Future<void> reloadPage() async {
    await fetchUploadedFiles();
    setState(() {
      _selectedFile=null;
    }); // Trigger a rebuild of the UI
  }



  Widget _buildUploadedFilesGrid(List<FileUpload> uploadedFiles) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns in the grid
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: uploadedFiles.length,
      itemBuilder: (context, index) {
        final file = uploadedFiles[index];
        final fileExtension = file.fileExtension.toLowerCase();

        // Determine the icon based on the file extension
        IconData iconData;
        if (fileExtension == 'jpg' || fileExtension == 'png') {
          iconData = Icons.image;
        } else {
          iconData = Icons.description;
        }

        return GestureDetector(
          onTap: () async {
            _downloadFile(file.filePath);
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
                  size: 40,
                ),
                const SizedBox(height: 8),
                Text(
                  file.fileName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
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
        title: const Center(
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
              else if (value == 'refresh') {
                reloadPage();
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
              const PopupMenuItem<String>(
                value: 'refresh',
                child: ListTile(
                  leading: Icon(Icons.refresh),
                  title: Text('Refresh'),
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
                padding: const EdgeInsets.all(8.0),
                child: _buildUploadedFilesGrid(uploadedFiles),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(bottom: 20), // Adjust the margin here
              child: ElevatedButton(
                onPressed: _uploadFile,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ), backgroundColor: const Color(0xff66d0ed),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                ),
                child: const Text('Upload File'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
