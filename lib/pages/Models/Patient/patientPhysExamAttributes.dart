class physExamAtt {
  final String peaId;
  final String peaName;
  final String physExamId;

  physExamAtt({
    required this.peaId,
    required this.peaName,
    required this.physExamId,
  });

  factory physExamAtt.fromJson(Map<String, dynamic> json) {
    return physExamAtt(
      peaId: json['PEA_id'],
      peaName: json['PEA_name'],
      physExamId: json['physicalExam_id'],
    );
  }
}