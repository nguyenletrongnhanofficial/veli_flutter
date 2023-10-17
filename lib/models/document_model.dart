import 'package:veli_flutter/models/school_model.dart';
import 'package:veli_flutter/models/subject_model.dart';

class DocumentModel {
  final String id;
  final String name;
  final String description;
  final num price;
  final bool isSold;
  final bool isFree;
  final String address;
  final String createdBy;
  final String createdAt;
  final List<String> images;
  final SchoolModel? school;
  final SubjectModel? subject;

  DocumentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.isSold,
    required this.isFree,
    required this.address,
    required this.createdAt,
    required this.createdBy,
    required this.images,
    required this.school,
    required this.subject,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['_id'] ?? json['id'],
      name: json['full_name'] ?? json['name'],
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      isSold: json["is_sold"] ?? '' ,
      isFree: json["is_free"] ?? '' ,
      address: json["address"] ?? '' ,
      createdBy: json["created_by"] ?? '' ,
      createdAt: json["created_at"] ?? '' ,
      images: json["images"] ?? [] ,
      school: SchoolModel.fromJson(json["school"]),
      subject: SubjectModel.fromJson(json["subject"]),
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
