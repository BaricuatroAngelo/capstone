class Medicine {
  final String medicineId;
  final String medicineBrand;
  final String medicineDosage;
  final String medicinePrice;

  Medicine({
    required this.medicineId,
    required this.medicineBrand,
    required this.medicineDosage,
    required this.medicinePrice,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      medicineId: json['medicine_id'],
      medicineBrand: json['medicine_brand'],
      medicineDosage: json['medicine_dosage'],
      medicinePrice: json['medicine_price'],
    );
  }
}
