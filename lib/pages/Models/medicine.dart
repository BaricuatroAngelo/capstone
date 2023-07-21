class Medicine {
  String medicineId;
  String medicineName;
  String medicineBrand;
  String medicineDosage;
  String medicinePrice;
  String medicineType;

  Medicine({
    required this.medicineId,
    required this.medicineName,
    required this.medicineBrand,
    required this.medicineDosage,
    required this.medicinePrice,
    required this.medicineType,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      medicineId: json['medicine_id'],
      medicineName: json['medicine_name'],
      medicineBrand: json['medicine_brand'],
      medicineDosage: json['medicine_dosage'],
      medicinePrice: json['medicine_price'],
      medicineType: json['medicine_type'],
    );
  }
}
