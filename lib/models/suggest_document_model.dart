class SuggestDocumentModel {
  final String id;
  final String name;
  final String code;
  final String image;

  SuggestDocumentModel({
    required this.id,
    required this.name,
    required this.code,
    required this.image,
  });

  factory SuggestDocumentModel.fromJson(Map<String, dynamic> json) {
    return SuggestDocumentModel(
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
