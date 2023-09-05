class Results {
  final String resultsId;
  final String results;
  final String labResultDate;
  final String patientId;

  Results({
    required this.resultsId,
    required this.results,
    required this.labResultDate,
    required this.patientId,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      resultsId: json['labResults_id'],
      labResultDate: json['labResultDate'],
      results: json['results'],
      patientId: json['patient_id'],
    );
  }
}
