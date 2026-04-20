part of 'block_bloc.dart';

@immutable
sealed class BlockState {}

final class BlockInitial extends BlockState {}

final class BlockLoading extends BlockState {}

final class BlockSuccess extends BlockState {
  final String successMsg;
  final bool isBlocked;

  BlockSuccess({required this.successMsg, required this.isBlocked});
}

final class BlockedUserIdsLoaded extends BlockState {
  final List<String> blockedUserIds;

  BlockedUserIdsLoaded({required this.blockedUserIds});
}

final class BlockError extends BlockState {
  final String errorMsg;

  BlockError({required this.errorMsg});
}
