class SchoolModel {
  final String id;
  final String name;
  final String code;
  final String image;

  SchoolModel({
    required this.id,
    required this.name,
    required this.code,
    required this.image,
  });

  factory SchoolModel.fromJson(Map<String, dynamic> json) {
    return SchoolModel(
      id: json['_id'] ?? json['id'],
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      image: json['image'] ?? '',
    );
  }

  toJson() {
    Map<String, dynamic> data = {
      "id": id,
      "code": code,
      "name": name,
      "image": image,
    };
    return data;
  }
}
