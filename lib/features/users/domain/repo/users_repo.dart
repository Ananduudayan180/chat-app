import 'package:chat_app/features/profile/domain/entity/profile_model.dart';

abstract class UsersRepo {
  Future<List<ProfileModel>> fetchUsers();
}
