import 'package:chat_app/features/chat/domain/entity/chat_model.dart';

abstract class ChatRepo {
  Stream<List<ChatModel>> streamChats(String currentUserUid);
}
