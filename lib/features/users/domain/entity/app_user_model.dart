class AppUserModel {
  final String uid;
  final String name;
  final String profileImageUrl;
  final List<String> blockedUserIds;

  AppUserModel({
    required this.uid,
    required this.name,
    required this.profileImageUrl,
    required this.blockedUserIds,
  });
}
