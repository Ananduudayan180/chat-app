import 'package:chat_app/features/search/data/service/search_service.dart';
import 'package:chat_app/features/search/domain/repo/search_repo.dart';
import 'package:chat_app/features/users/domain/entity/app_user_model.dart';

class SearchRepoImpl implements SearchRepo {
  final SearchService _searchService;

  SearchRepoImpl({required SearchService searchService})
    : _searchService = searchService;
  //search
  @override
  Future<List<AppUserModel>> searchUsers(String query) =>
      _searchService.searchUsers(query);
}
