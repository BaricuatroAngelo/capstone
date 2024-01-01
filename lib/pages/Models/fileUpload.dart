class FileUpload {
  final String fileId;
  final String filePath;
  final String fileName;
  final int fileSize;
  final String fileExtension;
  final String patientId;
  final String residentId;

  FileUpload({
    required this.fileId,
    required this.filePath,
    required this.fileName,
    required this.fileSize,
    required this.fileExtension,
    required this.patientId,
    required this.residentId,
  });

  factory FileUpload.fromJson(Map<String, dynamic> json) {
    return FileUpload(
      fileId: json['file_id'],
      filePath: json['file_path'],
      fileName: json['file_name'],
      fileSize: int.tryParse(json['file_size'] ?? '') ?? 0,
      fileExtension: json['file_ext'],
      patientId: json['patient_id'],
      residentId: json['resident_id'],
    );
  }
}
