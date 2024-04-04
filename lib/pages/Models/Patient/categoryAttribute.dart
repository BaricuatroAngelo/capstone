class CategoryAttribute {
  final String categoryAtt_id;
  final String categoryAtt_name;
  final String categoryAtt_returnName;
  final String categoryAtt_dataType;
  final String formCat_id;

  CategoryAttribute({
    required this.categoryAtt_id,
    required this.categoryAtt_name,
    required this.categoryAtt_returnName,
    required this.categoryAtt_dataType,
    required this.formCat_id,
});

  factory CategoryAttribute.fromJson(Map<String, dynamic> json) {
    return CategoryAttribute(
      categoryAtt_id: json['categoryAtt_id'],
      categoryAtt_name: json['categoryAtt_name'] ?? '',
      categoryAtt_returnName: json['categoryAtt_returnName'] ?? '',
      categoryAtt_dataType: json['categoryAtt_dataType'] ?? '',
      formCat_id: json['formCat_id'],
    );
  }
}