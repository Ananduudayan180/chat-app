import 'package:chat_app/features/chat/domain/entity/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<MessageModel>> streamMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final message = doc.data();
            return MessageModel.fromJson(message);
          }).toList();
        });
  }
}
