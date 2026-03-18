import 'package:chat_app/features/auth/domain/entity/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<UserModel?> loginUser(String email, String pw);
  Future<UserModel?> registerUser(String name, String email, String pw);
  Future<void> logoutUser();
  User? checkAuthStatus();
}
