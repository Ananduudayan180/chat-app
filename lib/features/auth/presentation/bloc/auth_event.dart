part of 'auth_bloc.dart';

abstract class AuthEvent {}

final class LoginRequested extends AuthEvent {
  final String email;
  final String pw;

  LoginRequested({required this.email, required this.pw});
}

final class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String pw;

  RegisterRequested({
    required this.name,
    required this.email,
    required this.pw,
  });
}

final class LogoutRequested extends AuthEvent {}
