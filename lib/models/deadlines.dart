class Deadlines {
  final String id;
  final int lowerBound;
  final int upperBound;
  final String userId;

  Deadlines({
    required this.id,
    required this.lowerBound,
    required this.upperBound,
    required this.userId,
  });

  factory Deadlines.fromJson(Map<String, dynamic> json) {
    return Deadlines(
      id: json['id'],
      lowerBound: json['upper_bound'],
      upperBound: json['lower_bound'],
      userId: json['user_id'],
    );
  }
}
