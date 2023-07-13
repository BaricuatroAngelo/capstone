class PInfoResults {
  final String pInfoId;
  final String resultsId;

  PInfoResults({
    required this.pInfoId,
    required this.resultsId,
  });

  factory PInfoResults.fromJson(Map<String, dynamic> json) {
    return PInfoResults(
      pInfoId: json['pInfo_id'],
      resultsId: json['results_id'],
    );
  }
}
