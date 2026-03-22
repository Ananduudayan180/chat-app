import 'package:chat_app/features/profile/domain/entity/profile_model.dart';

abstract class ProfileRepo {
  Future<ProfileModel?> fetchUserProfile(String uid);
}
