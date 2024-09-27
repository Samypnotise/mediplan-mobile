import 'package:mediplan/status/form_submission_status.dart';

class LoginState {
  final String email;
  bool get isValidEmail => email.isNotEmpty;

  final String password;
  bool get isValidPassword => password.isNotEmpty;

  final FormSubmissionStatus formStatus;

  LoginState({
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
