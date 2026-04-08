part of 'message_bloc.dart';

@immutable
sealed class MessageEvent {}

final class StreamMessageEvent extends MessageEvent {
  final String chatId;

  StreamMessageEvent({required this.chatId});
}
