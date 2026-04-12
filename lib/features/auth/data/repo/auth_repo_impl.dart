import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/auth/domain/entity/auth_model.dart';
import 'package:chat_app/features/auth/domain/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthService _authService;

  AuthRepoImpl({required AuthService authService}) : _authService = authService;
  @override
  Future<AuthModel?> loginUser(String email, String pw) =>
      _authService.loginUser(email, pw);

  @override
  Future<AuthModel?> registerUser(String name, String email, String pw) =>
      _authService.registerUser(name, email, pw);

  @override
  Future<void> logoutUser() => _authService.logoutUser();

  @override
  User? checkAuthStatus() => _authService.checkAuthStatus();

  //delete account
  @override
  Future<void> deleteAccount(String email, String pw) =>
      _authService.deleteAccount(email, pw);
}
