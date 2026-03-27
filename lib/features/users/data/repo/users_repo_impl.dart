import 'package:chat_app/features/users/data/service/users_service.dart';
import 'package:chat_app/features/users/domain/repo/users_repo.dart';
import 'package:chat_app/features/profile/domain/entity/profile_model.dart';

class UsersRepoImpl implements UsersRepo {
  final UsersService _usersService;

  UsersRepoImpl({required UsersService userService})
    : _usersService = userService;
  @override
  Future<List<ProfileModel>> fetchUsers() => _usersService.fetchUsers();
}
