class physExamAtt {
  final String peaId;
  final String peaName;
  final String physExamId;
  final String returnName;

  physExamAtt({
    required this.peaId,
    required this.peaName,
    required this.physExamId,
    required this.returnName,
  });

  factory physExamAtt.fromJson(Map<String, dynamic> json) {
    return physExamAtt(
      peaId: json['PEA_id'],
      peaName: json['PEA_name'],
      physExamId: json['physicalExam_id'],
      returnName: json['PEA_returnName'],
    );
  }
}