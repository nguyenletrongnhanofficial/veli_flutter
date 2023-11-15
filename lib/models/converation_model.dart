import 'package:veli_flutter/models/message_model.dart';
import 'package:veli_flutter/models/user_model.dart';

class ConversationModel {
  final String id;
  final String name;
  final List<UserModel> members;
  final String createdAt;
  final String updatedAt;
  final MessageModel? lastMessage;
  final int unreadCount;

  ConversationModel(
      {required this.id,
      required this.name,
      required this.members,
      required this.createdAt,
      required this.updatedAt,
      required this.lastMessage,
      required this.unreadCount,
      });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['_id'] ?? json['id'],
      name: json['name'] ?? "",
      members: (json['member_ids'] as List).map((user) => UserModel.fromJson(user)).toList(),
      lastMessage:json['last_message'] != null ? MessageModel.fromJson(json['last_message']) : null,
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
      unreadCount: json['unread_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'member_ids': members,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
