part of 'profile_bloc.dart';

sealed class ProfileEvent {}

final class FetchUserProfile extends ProfileEvent {
  final String uid;

  FetchUserProfile({required this.uid});
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

final class UpdateUserName extends ProfileEvent {
  final String currentUserUid;
  final String newName;

  UpdateUserName({required this.currentUserUid, required this.newName});
}

final class DeleteProfileImage extends ProfileEvent {
  final String currentUserUid;

  DeleteProfileImage({required this.currentUserUid});
}
