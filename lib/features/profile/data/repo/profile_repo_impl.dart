import 'dart:typed_data';
import 'package:chat_app/features/profile/data/service/profile_firestore_service.dart';
import 'package:chat_app/features/profile/data/service/profile_storage_service.dart';
import 'package:chat_app/features/profile/domain/entity/profile_model.dart';
import 'package:chat_app/features/profile/domain/repo/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileFirestoreService _firestoreService;
  final ProfileStorageService _storageService;

  ProfileRepoImpl({
    required ProfileFirestoreService firestoreService,
    required ProfileStorageService storageService,
  }) : _storageService = storageService,
       _firestoreService = firestoreService;

  //fetch user profile
  @override
  Future<ProfileModel?> fetchUserProfile(String uid) =>
      _firestoreService.fetchUserProfile(uid);

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
      _firestoreService.updateProfileImage(url, uid);

  @override
  Future<ProfileModel?> updateUserName(String currentUserUid, String newName) =>
      _firestoreService.updateUserName(currentUserUid, newName);
}
