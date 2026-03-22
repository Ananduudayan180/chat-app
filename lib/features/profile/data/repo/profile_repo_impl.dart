import 'package:chat_app/features/profile/data/service/profile_service.dart';
import 'package:chat_app/features/profile/domain/entity/profile_model.dart';
import 'package:chat_app/features/profile/domain/repo/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileService _profileService;

  ProfileRepoImpl({required ProfileService profileService})
    : _profileService = profileService;

  //fetch user profile
  @override
  Future<ProfileModel?> fetchUserProfile(String uid) =>
      _profileService.fetchUserProfile(uid);
}
