class physExamCat {
  final String physExamId;
  final String physExamName;
  final String physExamDesc;

  physExamCat ({
   required this.physExamId,
   required this.physExamName,
   required this.physExamDesc,
});

  factory physExamCat.fromJson(Map<String, dynamic> json) {
    return physExamCat(
      physExamId: json['physicalExam_id'],
      physExamName: json['PE_name'],
      physExamDesc: json['PE_description']
    );
  }
}