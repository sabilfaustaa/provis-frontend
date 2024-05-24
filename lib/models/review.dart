class Review {
  final int id;
  final String name;
  final String review;
  final int rating;
  final String time;

  Review({
    required this.id,
    required this.name,
    required this.review,
    required this.rating,
    required this.time,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      name: json['name'],
      review: json['review'],
      rating: json['rating'],
      time: json['time'],
    );
  }
}
