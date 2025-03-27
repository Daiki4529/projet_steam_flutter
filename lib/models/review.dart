class Review {
  final String authorId;
  final String reviewText;
  final double score;

  Review({
    required this.authorId,
    required this.reviewText,
    required this.score,
  });

  factory Review.fromJson(Map<String, dynamic> json) {    
    var value = json["weighted_vote_score"];
    double weightedScore;
    
    if (value is num) {
    // If it's already a numeric type, convert it directly.
    weightedScore = value.toDouble();
  } else if (value is String) {
    // If it's a string, try to parse it.
    weightedScore = double.tryParse(value) ?? 0.0;
  } else {
    // If it's neither, default to 0.0.
    weightedScore = 0.0;
  }

    double finalScore = weightedScore * 5;
    return Review(
      authorId: json['author']['steamid'] ?? '',
      reviewText: json['review'] ?? '',
      score: (finalScore * 2).round() / 2,
    );
  }
}
