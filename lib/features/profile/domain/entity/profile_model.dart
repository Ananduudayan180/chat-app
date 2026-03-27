import 'package:chat_app/features/auth/domain/entity/auth_model.dart';

class ProfileModel extends AuthModel {
  final String profileImageUrl;

  ProfileModel({
    required super.uid,
    required super.name,
    required super.email,
    required this.profileImageUrl,
  });
}
