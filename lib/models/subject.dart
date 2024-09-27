class Subject {
  final String id;
  final String title;
  final int semester;
  final String userId;

  Subject({
    required this.id,
    required this.title,
    required this.semester,
    required this.userId,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      title: json['title'],
      semester: json['semester'],
      userId: json['user_id'],
    );
  }
}
