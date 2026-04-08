part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class StreamChatsEvent extends ChatEvent {
  final String currentUserUid;

  StreamChatsEvent({required this.currentUserUid});
}
