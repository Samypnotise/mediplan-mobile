import 'package:mediplan/models/user.dart';

abstract class SessionState {}

class UnknownSessionState extends SessionState {}

class Unauthenticated extends SessionState {}

class Authenticated extends SessionState {
  final User user;
  final String token;

  Authenticated({required this.user, required this.token});
}
