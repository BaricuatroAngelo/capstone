class MedicineInfo {
  final String medicineInfoId;
  final DateTime medicineInfoDate;
  final String frequency;
  final String pInfoId;
  final String medicineId;

  MedicineInfo({
    required this.medicineInfoId,
    required this.medicineInfoDate,
    required this.frequency,
    required this.pInfoId,
    required this.medicineId,
  });

  factory MedicineInfo.fromJson(Map<String, dynamic> json) {
    return MedicineInfo(
      medicineInfoId: json['medicineInfo_id'],
      medicineInfoDate: DateTime.parse(json['medicineInfo_date']),
      frequency: json['frequency'],
      pInfoId: json['pInfo_id'],
      medicineId: json['medicine_id'],
    );
  }
}
