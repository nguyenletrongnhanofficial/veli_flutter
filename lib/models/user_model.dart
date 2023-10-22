class UserModel {
  final String id;
  final String username;
  final String avatar;
  final String phone;
  final int status;
  String? accessToken;
  bool? isOnline = false;

  UserModel({
    required this.id,
    required this.username,
    required this.avatar,
    required this.phone,
    required this.status, // 0 - Chưa kích xác thực, 1 - Đã xác thực
    this.accessToken,
    this.isOnline = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? json['id'],
      username: json['full_name'] ?? json['username'],
      avatar: json['avatar'] ?? 'assets/images/image_avt_default.jpg',
      status: json['status'] ?? 0,
      phone: json['phone'] ?? '',
      accessToken: json['accessToken'] ?? '',
      isOnline: (json['isOnline'] ?? false) as bool,
    );
  }

  toJson() {
    Map<String, dynamic> data = {
      "id": id,
      "avatar": avatar,
      "status": status,
      "username": username,
      "phone": phone,
      "accessToken": accessToken,
      "isOnline": isOnline,
    };
    return data;
  }
}
