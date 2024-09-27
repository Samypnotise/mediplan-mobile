class JMethod {
  final String id;
  final List<int> intervals;
  final String userId;

  JMethod({
    required this.id,
    required this.intervals,
    required this.userId,
  });

  factory JMethod.fromJson(Map<String, dynamic> json) {
    return JMethod(
      id: json['id'],
      intervals: json['intervals'],
      userId: json['user_id'],
    );
  }
}
