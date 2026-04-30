part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

final class SearchUsers extends SearchEvent {
  final String query;

  SearchUsers({required this.query});
}
