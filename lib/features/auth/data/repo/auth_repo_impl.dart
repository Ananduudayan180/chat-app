import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/auth/domain/entity/user_model.dart';
import 'package:chat_app/features/auth/domain/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthService _authService;

  AuthRepoImpl({required AuthService authService}) : _authService = authService;
  @override
  Future<UserModel?> loginUser(String email, String pw) =>
      _authService.loginUser(email, pw);

  @override
  Future<UserModel?> registerUser(String name, String email, String pw) =>
      _authService.registerUser(name, email, pw);

  @override
  Future<void> logoutUser() => _authService.logoutUser();

  @override
  User? checkAuthStatus() => _authService.checkAuthStatus();
}
