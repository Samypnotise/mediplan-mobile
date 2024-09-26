import 'package:mediplan/routes/basic_routes.dart';
import 'package:http/http.dart' as http;

class MediplanRepository {
  Future<http.Response> getUser({
    required String userId,
    required String token,
  }) async {
    final response = await http.get(
      Uri.parse(BasicRoutes.getById("users", userId)),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<http.Response> getUserSettings({
    required String userId,
    required String token,
  }) async {
    final response = await http.get(
      Uri.parse('${BasicRoutes.getById("users", userId)}/settings'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<http.Response> getUserDeadlines({
    required String userId,
    required String token,
  }) async {
    final response = await http.get(
      Uri.parse('${BasicRoutes.getById("users", userId)}/deadlines'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<http.Response> getUserJMethod({
    required String userId,
    required String token,
  }) async {
    final response = await http.get(
      Uri.parse('${BasicRoutes.getById("users", userId)}/j-method'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<http.Response> getUserLessons({
    required String userId,
    required String token,
  }) async {
    final response = await http.get(
      Uri.parse('${BasicRoutes.getById("users", userId)}/lessons'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<http.Response> getUserSubjects({
    required String userId,
    required String token,
  }) async {
    final response = await http.get(
      Uri.parse('${BasicRoutes.getById("users", userId)}/subjects'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<http.Response> getUserFlashcards({
    required String userId,
    required String token,
  }) async {
    final response = await http.get(
      Uri.parse('${BasicRoutes.getById("users", userId)}/flashcards'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<http.Response> getUserStudySessions({
    required String userId,
    required String token,
  }) async {
    final response = await http.get(
      Uri.parse('${BasicRoutes.getById("users", userId)}/study-sessions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }
}
