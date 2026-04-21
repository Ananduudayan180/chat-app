part of 'users_bloc.dart';

@immutable
sealed class UsersEvent {}

final class FetchUsers extends UsersEvent {
  final String currentUserUid;

  FetchUsers({required this.currentUserUid});
}
