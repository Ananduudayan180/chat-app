import 'package:chat_app/features/auth/domain/entity/user_model.dart';

class ProfileModel extends UserModel {
  final String profilePic;

  ProfileModel({
    required super.uid,
    required super.name,
    required super.email,
    required this.profilePic,
  });
}
