import 'package:chat_app/features/users/domain/entity/app_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //fetch all app users
  Future<List<AppUserModel>> fetchUsers() async {
    try {
      final usersCollection = await _firestore.collection('users').get();

      final usersDocs = usersCollection.docs;

      return usersDocs.map((doc) {
        final user = doc.data();
        return AppUserModel(
          uid: user['id'],
          name: user['name'],
          profileImageUrl: user['profileImageUrl'],
        );
      }).toList();
    } on Exception catch (e) {
      throw Exception('Failed to fetch users $e');
    }
  }
}
