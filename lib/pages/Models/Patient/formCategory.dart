class FormCat {
  final String formCat_id;
  final String formCat_name;
  final String formCat_description;

  FormCat({
    required this.formCat_id,
    required this.formCat_name,
    required this.formCat_description,
  });

  factory FormCat.fromJson(Map<String, dynamic> json) {
    return FormCat(
        formCat_id: json['formCat_id'],
        formCat_name: json['formCat_name'],
        formCat_description: json['formCat_description'] ?? '');
  }
}
