import 'package:chat_app/features/users/domain/entity/app_user_model.dart';

abstract class UsersRepo {
  Future<List<AppUserModel>> fetchUsers();
}
