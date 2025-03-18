class Review {
  final String id;
  final String authorId;
  final String reviewText;
  final int score;
  final bool votedUp;

  Review({
    required this.id,
    required this.authorId,
    required this.reviewText,
    required this.score,
    required this.votedUp,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['recommendationid'] ?? '',
      authorId: json['author']['steamid'] ?? '',
      reviewText: json['review'] ?? '',
      score: json['score'] ?? 0,
      votedUp: json['voted_up'] ?? false,
    );
  }
}
