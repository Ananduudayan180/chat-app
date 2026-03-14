part of 'auth_bloc.dart';

abstract class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class Authenticated extends AuthState {}

final class Unauthenticated extends AuthState {}

final class AuthError extends AuthState {
  final String errorMsg;

  AuthError({required this.errorMsg});
}
