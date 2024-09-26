import 'dart:ffi';

class StudySession {
  final String id;
  final DateTime date;
  final Float studyTime; // Number of minutes in study session
  final String lessonId;
  final String userId;

  StudySession({
    required this.id,
    required this.date,
    required this.studyTime,
    required this.lessonId,
    required this.userId,
  });

  factory StudySession.fromJson(Map<String, dynamic> json) {
    return StudySession(
      id: json['id'],
      date: json['date'],
      studyTime: json['study_time'],
      lessonId: json['lesson_id'],
      userId: json['user_id'],
    );
  }
}
