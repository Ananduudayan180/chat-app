import 'package:chat_app/features/users/domain/entity/app_user_model.dart';

abstract class SearchRepo {
  Future<List<AppUserModel>> searchUsers(String query);
}
