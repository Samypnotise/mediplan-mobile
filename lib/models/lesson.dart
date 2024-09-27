class Lesson {
  final String id;
  final String title;
  final DateTime lastTimeStudied;
  final int timesStudied;
  final String? notes;
  final String subjectId;
  final String userId;

  Lesson({
    required this.id,
    required this.title,
    required this.lastTimeStudied,
    required this.timesStudied,
    required this.notes,
    required this.subjectId,
    required this.userId,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      title: json['title'],
      lastTimeStudied: json['last_time_studied'],
      timesStudied: json['times_studied'],
      notes: json['notes'],
      subjectId: json['subject_id'],
      userId: json['user_id'],
    );
  }
}
