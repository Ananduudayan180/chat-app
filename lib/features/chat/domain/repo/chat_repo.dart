import 'package:chat_app/features/profile/domain/entity/profile_model.dart';

abstract class ChatRepo {
  Future<List<ProfileModel>> fetchAllUsers();
}
