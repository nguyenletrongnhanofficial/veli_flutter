class DistrictModel {
  final String id;
  final String name;

  DistrictModel({
    required this.id,
    required this.name,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
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
