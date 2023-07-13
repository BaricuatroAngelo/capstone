class Results {
  final String resultsId;
  final String result;

  Results({
    required this.resultsId,
    required this.result,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      resultsId: json['results_id'],
      result: json['result'],
    );
  }
}
