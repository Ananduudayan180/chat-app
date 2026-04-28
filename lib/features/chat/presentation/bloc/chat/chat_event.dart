part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class StreamChatsEvent extends ChatEvent {}

final class DeleteChatEvent extends ChatEvent {
  final String chatId;
  final String currentUserUid;

  DeleteChatEvent({required this.chatId, required this.currentUserUid});
}
