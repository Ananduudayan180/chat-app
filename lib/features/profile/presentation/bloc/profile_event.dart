part of 'profile_bloc.dart';

sealed class ProfileEvent {}

final class FetchProfileRequested extends ProfileEvent {
  final String uid;

  FetchProfileRequested({required this.uid});
}

final class UploadProfileImage extends ProfileEvent {
  final Uint8List? bytes;
  final String? path;
  final String fileName;
  final String uid;

  UploadProfileImage({
    required this.bytes,
    required this.path,
    required this.fileName,
    required this.uid,
  });
}
