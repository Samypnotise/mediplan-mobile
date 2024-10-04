import 'dart:convert';

import 'package:mediplan/routes/auth_routes.dart';
import 'package:mediplan/routes/basic_routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  //! Auto login method
  Future<http.Response> attemptAutoLogin({
    required String userId,
    required String token,
  }) async {
    final response = await http.get(
      Uri.parse(BasicRoutes.getById('users', userId)),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  //! Login method
  Future<http.Response> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(AuthRoutes.login),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    return response;
  }

  //! Get the user
  Future<http.Response> getUser({required String token}) async {
    final response = await http.get(
      Uri.parse("${BasicRoutes.get("profiles")}/me"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  //! Register method
  Future<http.Response> register({
    required String username,
    required String email,
    required String password,
  }) async {
    await http.post(
      Uri.parse(BasicRoutes.post('users')),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    final loginResponse = await login(email: email, password: password);

    return loginResponse;
  }

  //! Sign out method
  Future<void> signOut() async {
    await secureStorage.delete(key: 'jwt'); // Remove token
    await secureStorage.delete(key: 'userId');
  }
}
