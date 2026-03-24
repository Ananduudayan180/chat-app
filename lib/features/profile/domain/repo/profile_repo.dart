import 'dart:typed_data';
import 'package:chat_app/features/profile/domain/entity/profile_model.dart';

abstract class ProfileRepo {
  Future<ProfileModel?> fetchUserProfile(String uid);
  Future<String> uploadProfileImage({
    Uint8List? bytes,
    String? path,
    required String fileName,
  });
}
