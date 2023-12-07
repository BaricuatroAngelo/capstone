class AttributeValues {
  final String attributeVal_id;
  final String attributeVal_values;
  final String patientId;
  final String categoryAtt_id;

  AttributeValues({
 required this.attributeVal_id,
 required this.attributeVal_values,
 required this.patientId,
 required this.categoryAtt_id,
});

  factory AttributeValues.fromJson(Map<String, dynamic> json) {
    return AttributeValues(
      attributeVal_id: json['attributeVal_id'] ?? '',
      attributeVal_values: json['attributeVal_values'] ?? '',
      patientId: json['patient_id'] ?? '',
      categoryAtt_id: json['categoryAtt_id'] ?? '',
    );
  }
}