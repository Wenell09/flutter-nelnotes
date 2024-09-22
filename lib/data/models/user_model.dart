class UserModel {
  String userId, username, email, image, createdAt;

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.image,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["user_id"] ?? "",
      username: json["username"] ?? "",
      email: json["email"] ?? "",
      image: json["image"] ?? "",
      createdAt: json["created_at"] ?? "",
    );
  }
}
