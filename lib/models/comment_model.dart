class Comment {
  String customerId;
  int rating;
  String comment;
  String time;

  Comment({
    required this.customerId,
    required this.rating,
    required this.comment,
    required this.time
  });

  factory Comment.fromJson(Map<dynamic, dynamic> json) => Comment(
    customerId: json["CustomerId"],
    rating: json["Rating"],
    comment: json["Comment"],
    time: json["Time"]
  );

  toJson() => {
    "CustomerId": customerId,
    "Rating": rating,
    "Comment": comment,
    "Time": time
  };
}
