import 'dart:convert';

import 'package:mediplan/models/lesson.dart';
import 'package:mediplan/routes/basic_routes.dart';
import 'package:http/http.dart' as http;

class LessonRepository {
  Future<http.Response> createLesson({
    required Lesson lesson,
    required String token,
  }) async {
    final response = await http.post(
      Uri.parse(BasicRoutes.post("lessons")),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(lesson),
    );

    return response;
  }

  Future<http.Response> updateLesson({
    required Lesson lesson,
    required String token,
  }) async {
    final response = await http.patch(
      Uri.parse(BasicRoutes.update("lessons", lesson.id)),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(lesson),
    );

    return response;
  }

  Future<http.Response> deleteLesson({
    required String lessonId,
    required String token,
  }) async {
    final response = await http.delete(
      Uri.parse(BasicRoutes.delete("lessons", lessonId)),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'lesson_id': lessonId,
      }),
    );

    return response;
  }
}
