part of 'message_bloc.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}

final class MessageLoading extends MessageState {}

final class MessageLoaded extends MessageState {
  final List<MessageModel> messages;

  MessageLoaded({required this.messages});
}

final class MessageError extends MessageState {
  final String errorMsg;

  MessageError({required this.errorMsg});
}
