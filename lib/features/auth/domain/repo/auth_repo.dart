import 'package:chat_app/features/auth/domain/entity/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<AuthModel?> loginUser(String email, String pw);
  Future<AuthModel?> registerUser(String name, String email, String pw);
  Future<void> logoutUser();
  User? checkAuthStatus();
}
