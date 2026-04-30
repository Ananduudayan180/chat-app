part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final List<AppUserModel> users;

  SearchLoaded({required this.users});
}

final class SearchError extends SearchState {
  final String errorMsg;

  SearchError({required this.errorMsg});
}
