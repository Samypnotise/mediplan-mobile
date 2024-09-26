import 'dart:convert';

import 'package:mediplan/models/user.dart';
import 'package:mediplan/blocs/login_bloc/login_event.dart';
import 'package:mediplan/blocs/login_bloc/login_state.dart';
import 'package:mediplan/blocs/auth_bloc/auth_cubit.dart';
import 'package:mediplan/repositories/auth_repository.dart';
import 'package:mediplan/status/form_submission_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthCubit authCubit;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  LoginBloc({required this.authRepository, required this.authCubit})
      : super(LoginState()) {
    on<LoginEmailChanged>((event, emit) async {
      emit(state.copyWith(email: event.email.toLowerCase()));
    });

    on<LoginPasswordChanged>((event, emit) async {
      emit(state.copyWith(password: event.password));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmittting()));

      try {
        final response = await authRepository.login(
          email: state.email,
          password: state.password,
        );

        if (response.statusCode == 201) {
          final data = jsonDecode(response.body);
          final token = data['accessToken'];

          final user = User.fromJson({
            'id': data?['user']?['id'],
            'username': data?['user']?['username'],
            'email': data?['user']?['email'],
          }); // Assuming you have a User model

          // Save JWT locally
          await secureStorage.write(key: 'jwt', value: token);
          // Save userId locally
          await secureStorage.write(key: 'userId', value: user.id);

          emit(state.copyWith(formStatus: SubmissionSuccess()));

          authCubit.launchSession(user: user, token: token);
        } else {
          emit(
            state.copyWith(
              formStatus: SubmissionFailed(
                Exception('Erreur.'),
              ),
            ),
          );
        }

        emit(state.copyWith(formStatus: const InitialFormStatus()));

        emit(state.copyWith(formStatus: SubmissionSuccess()));
        // Resetting to avoid flushbars when changing email/password values
        emit(state.copyWith(formStatus: const InitialFormStatus()));
      } catch (error) {
        emit(state.copyWith(formStatus: SubmissionFailed(Exception(error))));
        // Resetting to avoid flushbars when changing email/password values
        emit(state.copyWith(formStatus: const InitialFormStatus()));
      }
    });
  }
}
