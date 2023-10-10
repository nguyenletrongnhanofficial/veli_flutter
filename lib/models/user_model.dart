class UserModel {
  final String id;
  final String username;
  final String avatar;
  final String phone;
  String? accessToken;
  bool? isOnline = false;

  UserModel({
    required this.id,
    required this.username,
    required this.avatar,
    required this.phone,
    this.accessToken,
    this.isOnline,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? json['id'],
      username: json['full_name'] ?? json['username'],
      avatar: json['avatar'] ?? '',
      phone: json['phone'] ?? '',
      accessToken: json['accessToken'] ?? '',
      isOnline: json['isOnline'] ?? false,
    );
  }

  toJson() {
    Map<String, dynamic> data = {
      "id": id,
      "avatar": avatar,
      "username": username,
      "phone": phone,
      "accessToken": accessToken,
      "isOnline": isOnline,
    };
    return data;
  }
}
