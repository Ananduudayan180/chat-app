import 'package:chat_app/features/chat/domain/entity/chat_model.dart';
import 'package:chat_app/features/chat/domain/entity/message_model.dart';

abstract class ChatRepo {
  Stream<List<ChatModel>> streamChats(String currentUserUid);
  Stream<List<MessageModel>> streamMessages(String chatId);
}
