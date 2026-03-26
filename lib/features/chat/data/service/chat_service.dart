import 'package:chat_app/features/profile/domain/entity/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//fetch all app users
  Future<List<ProfileModel>> fetchAllUsers() async {
    try {
      final usersCollection = await _firestore
          .collection('user_profiles')
          .get();

      final usersDocs = usersCollection.docs;

      return usersDocs.map((doc) {
        final user = doc.data();
        return ProfileModel(
          uid: user['id'],
          name: user['name'],
          email: user['email'],
          profileImageUrl: user['profileImageUrl'],
        );
      }).toList();
    } on Exception catch (e) {
      throw Exception('Failed to fetch users $e');
    }
  }
}
