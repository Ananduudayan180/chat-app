import 'package:chat_app/features/auth/domain/entity/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //login
  Future<UserModel?> loginUser(String email, String pw) async {
    try {
      UserCredential userData = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pw,
      );

      if (userData.user == null) return null;

      return UserModel(
        uid: userData.user!.uid,
        name: '',
        email: userData.user!.email!,
      );
    } on FirebaseAuthException {
      rethrow;
    } catch (_) {
      throw Exception('Something went wrong. Please try again later');
    }
  }

  //register
  Future<UserModel?> registerUser(String name, String email, String pw) async {
    try {
      UserCredential userData = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pw,
      );

      if (userData.user == null) return null;

      return UserModel(
        uid: userData.user!.uid,
        name: name,
        email: userData.user!.email!,
      );
    } on FirebaseAuthException {
      rethrow;
    } catch (_) {
      throw Exception('Something went wrong. Please try again later');
    }
  }

  //logout
  Future<void> logoutUser() async {
    try {
      await _auth.signOut();
      _auth.authStateChanges();
    } on FirebaseAuthException {
      rethrow;
    } catch (_) {
      throw Exception('Something went wrong. Please try again later');
    }
  }

  //get current user uid
  String get currentUserUid => _auth.currentUser!.uid;
}
