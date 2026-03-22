part of 'profile_bloc.dart';

sealed class ProfileEvent {}

final class FetchProfileRequested extends ProfileEvent {
  final String uid;

  FetchProfileRequested({required this.uid});
}
