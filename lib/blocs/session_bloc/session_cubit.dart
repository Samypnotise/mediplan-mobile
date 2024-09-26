import 'dart:convert';

import 'package:mediplan/models/user.dart';
import 'package:mediplan/repositories/auth_repository.dart';
import 'package:mediplan/blocs/session_bloc/session_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepository;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  SessionCubit({required this.authRepository}) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    print("auto login");
    final token = await secureStorage.read(key: 'jwt');
    final userId = await secureStorage.read(key: 'userId');

    if (token != null && userId != null) {
      try {
        final response =
            await authRepository.attemptAutoLogin(token: token, userId: userId);

        final data = jsonDecode(response.body);
        final user = User.fromJson({
          'id': data?['id'],
          'username': data?['username'],
          'email': data?['email'],
        }); // Assuming you have a User model

        showSession(user, token);
      } catch (e) {
        emit(Unauthenticated());
      }
    } else {
      emit(Unauthenticated());
    }
  }

  void showAuthentication() => emit(Unauthenticated());

  void showSession(User user, String token) {
    emit(Authenticated(user: user, token: token));
  }

  void signOut() {
    authRepository.signOut();

    emit(Unauthenticated());
  }
}
