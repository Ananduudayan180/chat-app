import 'package:chat_app/features/auth/domain/entity/auth_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //login
  Future<AuthModel?> loginUser(String email, String pw) async {
    try {
      UserCredential userData = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pw,
      );

      if (userData.user == null) return null;

      return AuthModel(
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
  Future<AuthModel?> registerUser(String name, String email, String pw) async {
    try {
      UserCredential userData = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pw,
      );

      if (userData.user == null) return null;

      final userModel = AuthModel(
        uid: userData.user!.uid,
        name: name,
        email: userData.user!.email!,
      );

      //save app users in firestore
      _firestore
          .collection('users')
          .doc(userData.user!.uid)
          .set(userModel.toJson());

      return userModel;
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

  //check auth status
  User? checkAuthStatus() => _auth.currentUser;
}
