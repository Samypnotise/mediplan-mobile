import 'package:mediplan/models/user.dart';
import 'package:mediplan/blocs/auth_bloc/auth_state.dart';
import 'package:mediplan/repositories/auth_repository.dart';
import 'package:mediplan/blocs/session_bloc/session_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  final SessionCubit sessionCubit;

  AuthCubit({required this.authRepository, required this.sessionCubit})
      : super(Login());

  void showLoginView() => emit(Login());
  void showForgottenPasswordView() => emit(ForgottenPassword());

  void launchSession({required User user, required String token}) =>
      sessionCubit.showSession(user, token);
}
