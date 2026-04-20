import 'package:chat_app/features/users/domain/entity/app_user_model.dart';

abstract class UsersRepo {
  Future<List<AppUserModel>> fetchUsers();
  Future<void> blockUser(String currentUserUid, String otherUserUid);
  Future<void> unblockUser(String currentUserUid, String otherUserUid);
}
