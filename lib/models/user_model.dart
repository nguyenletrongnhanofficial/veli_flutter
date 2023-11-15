import 'package:veli_flutter/models/school_model.dart';

class UserModel {
  final String id;
  final String username;
  final String avatar;
  final String phone;
  final String gender;
  final String email;
  final String dateOfBirth;
  final String address;
  final SchoolModel? school;
  final int status;
  String? accessToken;
  bool? isOnline = false;

  UserModel({
    required this.id,
    required this.username,
    required this.avatar,
    required this.phone,
    required this.gender,
    required this.email,
    required this.dateOfBirth,
    required this.address,
    required this.school,
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
      gender: json['gender'] ?? 'male',
      dateOfBirth: json['date_of_birth'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      school: (json['school_id'] != null) ? SchoolModel.fromJson(json['school_id']) : null,
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
      "email": email,
      "address": address,
      // "school_id": SchoolModel.fromJson(school as dynamic),
      "date_of_birth": dateOfBirth,
      "accessToken": accessToken,
      "isOnline": isOnline,
    };
    return data;
  }
}
