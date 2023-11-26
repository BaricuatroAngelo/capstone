class physExamVal {
  final String pavId;
  final String pavValue;
  final String peaId;
  final String patient_id;

  physExamVal ({
   required this.pavId,
   required this.pavValue,
   required this.peaId,
   required this.patient_id,
});

  factory physExamVal.fromJson(Map<String, dynamic> json) {
    return physExamVal (
      pavId: json['PAV_id'],
      pavValue: json['PAV_value'],
      peaId: json['PEA_id'],
      patient_id: json['patient_id']
    );
  }
}