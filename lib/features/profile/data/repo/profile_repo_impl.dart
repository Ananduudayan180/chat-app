import 'dart:typed_data';
import 'package:chat_app/features/profile/data/service/profile_service.dart';
import 'package:chat_app/features/profile/data/service/profile_storage_service.dart';
import 'package:chat_app/features/profile/domain/entity/profile_model.dart';
import 'package:chat_app/features/profile/domain/repo/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileService _profileService;
  final ProfileStorageService _storageService;

  ProfileRepoImpl({
    required ProfileService profileService,
    required ProfileStorageService storageService,
  }) : _storageService = storageService,
       _profileService = profileService;

  //fetch user profile
  @override
  Future<ProfileModel?> fetchUserProfile(String uid) =>
      _profileService.fetchUserProfile(uid);

  //upload profile image
  @override
  Future<String> uploadProfileImage({
    Uint8List? bytes,
    String? path,
    required String fileName,
  }) => _storageService.uploadProfileImage(
    fileName: fileName,
    bytes: bytes,
    path: path,
  );

  //update profile image
  @override
  Future<void> updateProfileImage(String url, String uid) =>
      _profileService.updateProfileImage(url, uid);
}
