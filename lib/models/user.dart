class UserModel {
  final int userId;
  final String accessToken;

  UserModel({required this.userId, required this.accessToken});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      accessToken: json['access_token'],
    );
  }
}
