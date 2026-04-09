part of 'message_bloc.dart';

@immutable
sealed class MessageEvent {}

final class StreamMessageEvent extends MessageEvent {
  final String chatId;

  StreamMessageEvent({required this.chatId});
}

final class SaveMessageEvent extends MessageEvent {
  final MessageModel message;
  final String chatId;
  final List<String> participants;

  SaveMessageEvent({
    required this.message,
    required this.chatId,
    required this.participants,
  });
}
