import 'package:veli_flutter/models/school_model.dart';
import 'package:veli_flutter/models/subject_model.dart';
import 'package:veli_flutter/models/user_model.dart';

class DocumentModel {
  final String id;
  final String name;
  final String description;
  final num price;
  final bool isSold;
  final bool isSaved;
  final bool isFree;
  final String address;
  final UserModel? createdBy;
  final String createdAt;
  final String districtId;
  final List<String> images;
  final SchoolModel? school;
  final SubjectModel? subject;

  DocumentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.isSold,
    required this.isSaved,
    required this.isFree,
    required this.address,
    required this.createdBy,
    required this.createdAt,
    required this.districtId,
    required this.images,
    required this.school,
    required this.subject,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['_id'] ?? json['id'],
      name:  json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      isSold: (json["is_sold"] ?? false) as bool,
      isFree: (json["is_free"] ?? false) as bool,
      isSaved: (json["is_saved"] ?? false) as bool,
      address: json["address"] ?? '' ,
      createdBy: UserModel.fromJson(json["created_by"] as Map<String, dynamic>),
      createdAt: json["created_at"] ?? '' ,
      districtId: json["district_id"] ?? '' ,
      images: json["images"] != null ? (json['images'] as List).map((image) => image as String).toList() : [],
 //     images: json["images"] ? json['images'].map((image) => image as String).toList() : [],
      school: SchoolModel.fromJson(json["school"] as Map<String, dynamic>),
      subject: SubjectModel.fromJson(json["subject"] as Map<String, dynamic>),
    );
  }

  toJson() {
    Map<String, dynamic> data = {
      "id": id,
      "description": description,
      "name": name,
      "price": price,
      "isSold": isSold,
      "isFree": isFree,
      "isSaved": isSaved,
      "address": address,
      "createdAt": createdAt,
      "createdBy": createdBy,
      "images": images,
      "school": school,
      "subject": subject,
    };
    return data;
  }
}
