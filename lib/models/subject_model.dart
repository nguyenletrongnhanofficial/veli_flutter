class SubjectModel {
  final String id;
  final String name;

  SubjectModel({
    required this.id,
    required this.name,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['_id'] ?? json['id'],
      name: json['name'] ?? '',
    );
  }

  toJson() {
    Map<String, dynamic> data = {
      "id": id,
      "name": name,
    };
    return data;
  }
}
