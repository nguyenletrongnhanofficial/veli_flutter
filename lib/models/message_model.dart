class MessageModel {
  final String user_id;
  final String username;
  final String message;
  final DateTime time;

  MessageModel(
      {required this.user_id,
      required this.username,
      required this.message,
      required this.time});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      user_id: json['user_id'],
      username: json['username'],
      message: json['message'],
      time: DateTime.parse(json['time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': user_id,
      'username': username,
      'message': message,
      'time': time.toIso8601String(),
    };
  }
}
