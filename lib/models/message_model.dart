import 'package:veli_flutter/models/user_model.dart';

class MessageModel {
  final String id;
  final String content;
  final UserModel? createdBy;
  final String? createdAt;
  final String? updatedAt;

  MessageModel(
      {required this.id,
      required this.content,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'] ?? json['id'],
      content: json['content'],
      createdBy: json['created_by'] != null ? UserModel.fromJson(json["created_by"] as Map<String, dynamic>): null,
      createdAt: json["createdAt"] ?? '',
      updatedAt: json["updatedAt"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'createdAt': createdAt,
      'createdBy': createdBy,
      'updatedAt': updatedAt,
    };
  }
}
