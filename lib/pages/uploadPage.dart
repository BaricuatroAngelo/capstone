import 'dart:convert';
import 'dart:io';
import 'package:capstone/pages/Models/fileUpload.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../design/containers/widgets/urlWidget.dart';

class FileUploadPage extends StatefulWidget {
  final String authToken;
  final String residentId;
  final String patientId;

  const FileUploadPage({
    Key? key,
    required this.authToken,
    required this.residentId,
    required this.patientId,
  }) : super(key: key);

  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  File? _selectedFile;
  List<FileUpload> uploadedFiles = [];
  final Set<String> selectedFiles = <String>{};

  void _showSnackBar(String message, String s) {
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
        print(await response.stream.bytesToString());
        if (response.statusCode == 200) {
          _showSnackBar(context as String, 'Upload success');
          await reloadPage();
        } else {
          _showSnackBar(context as String, 'Failed to upload file');
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
        url,
        headers: {
          'Authorization': 'Bearer ${widget.authToken}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final List<FileUpload> filesUpload = responseData
            .map((data) => FileUpload.fromJson(data))
            .toList();

        // Filter files based on patientId
        final List<FileUpload> filteredFiles = filesUpload
            .where((file) => file.patientId == widget.patientId)
            .toList();

        setState(() {
          uploadedFiles = filteredFiles;
        });
      } else {
        print('Failed to fetch files: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching files: $e');
    }
  }


  // Future<void> fetchUploadedFiles() async {
  //   try {
  //     final url = Uri.parse('${Env.prefix}/api/fileUpload');
  //     final response = await http.get(
  //       url.replace(queryParameters: {
  //         'residentId': widget.residentId,
  //         'patientId': widget.patientId,
  //       }),
  //       headers: {
  //         'Authorization': 'Bearer ${widget.authToken}',
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final List<dynamic> responseData = json.decode(response.body);
  //       final List<FileUpload> filesUpload = responseData
  //           .map((data) => FileUpload.fromJson(data))
  //           .toList();
  //       setState(() {
  //         uploadedFiles = filesUpload;
  //       });
  //     } else {
  //       print('Failed to fetch files: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error fetching files: $e');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // Fetch uploaded files on page load
    fetchUploadedFiles();
  }

  // Inside the _downloadFile method
  void _downloadFile(BuildContext context, String fileId, String fileName, String fileExtension) async {
    try {
      final url = Uri.parse('${Env.prefix}/api/fileUpload/download/$fileId');
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${widget.authToken}'},
      );

      if (response.statusCode == 200) {
        final fileBytes = response.bodyBytes;

        // Set the custom directory path
        final customDirectory = Directory('/storage/emulated/0/Download/');
        if (!await customDirectory.exists()) {
          await customDirectory.create(recursive: true);
        }

        // Create the file path
        final filePath = '${customDirectory.path}/$fileName';
        final file = File(filePath);

        // Write the file
        await file.writeAsBytes(fileBytes);

        print('File downloaded successfully: $filePath');

        // Show a success message dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Download Success'),
              content: Text('File downloaded successfully: $filePath'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        throw 'Failed to download file: ${response.statusCode}';
      }
    } catch (e) {
      print('Error downloading file: $e');
      // Handle error
    }
  }

  Future<void> reloadPage() async {
    await fetchUploadedFiles();
    setState(() {
      _selectedFile = null;
      selectedFiles.clear();
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

        return InkWell(
          onTap: () {
            _downloadFile(context, file.fileId, file.fileName, file.fileExtension);
          },
          onLongPress: () {
            _toggleFileSelection(context, file.fileId , file.fileName, file.fileExtension);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
              color: selectedFiles.contains(file.fileId)
                  ? Colors.blue.withOpacity(0.3)
                  : Colors.transparent,
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
                ElevatedButton.icon(
                  onPressed: () {
                    _viewFile(file.fileId);
                  },
                  icon: const Icon(Icons.visibility),
                  label: const Text('View'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  void _toggleFileSelection(BuildContext context, String fileId, String fileName, String fileExtension) {
    setState(() {
      if (selectedFiles.contains(fileId)) {
        selectedFiles.remove(fileId);
      } else {
        if (selectedFiles.isEmpty) {
          _downloadFile(context, fileId, fileName, fileExtension); // Download the file with fileName and fileExtension
        } else {
          selectedFiles.add(fileId); // Toggle file selection
        }
      }
    });
  }



  Future<void> _viewFile(String fileId) async {
    try {
      final url = Uri.parse('${Env.prefix}/api/fileUpload/viewFile/$fileId');
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${widget.authToken}'},
      );

      if (response.statusCode == 200) {
        final directory = await getTemporaryDirectory();
        final String contentType = response.headers['content-type'] ?? '';
        String extension = '';

        // Determine file extension based on content type
        if (contentType.contains('application/pdf')) {
          extension = '.pdf';
        } else if (contentType.contains('image/jpeg')) {
          extension = '.jpeg';
        } else if (contentType.contains('image/png')) {
          extension = '.png';
        } else {
          throw 'Unsupported file type';
        }

        final filePath = '${directory.path}/$fileId$extension';

        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        // Check if the file exists and open it
        if (await file.exists()) {
          OpenFile.open(filePath);
        } else {
          throw 'Failed to write file: File does not exist';
        }
            } else {
        throw 'Failed to download file: ${response.statusCode}';
      }
    } catch (e) {
      print('Error viewing file: $e');
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(
          content: Text('Error viewing file: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
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
              } else if (value == 'refresh') {
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