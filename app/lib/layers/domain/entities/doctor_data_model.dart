import 'package:app/layers/domain/entities/base_enity.dart';
import 'package:app/layers/domain/service/json_serializable.dart';

class DoctorDataModel extends BaseEntity implements JsonSerializable {
  final String name;
  final String category;
  final double rate;
  final int count;

  final int views;
  final int experiences;
  final String available;
  final int price;

  DoctorDataModel({
    required super.id,
    required this.name,
    required this.category,
    required this.rate,
    required this.count,
    required super.image,
    required this.views,
    required this.experiences,
    required this.available,
    required this.price,
  });

  factory DoctorDataModel.fromMap(Map<String, dynamic> map) {
    return DoctorDataModel(
      id: map["id"] ?? 0,
      name: map["nameDoctor"] ?? "error",
      category: map["category"] ?? "error",
      rate: map["rate"] ?? 5,
      count: map["count"] ?? 0,
      image: map["image"] ?? "error",
      views: map["views"] ?? 0,
      experiences: map["experiences"] ?? 0,
      available: map["available"] ?? "16:30:04",
      price: map["price"] ?? 100,
    );
  }
}
