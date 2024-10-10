import 'package:app/service/json_serializable.dart';
import 'package:equatable/equatable.dart';

class DoctorDataModel with EquatableMixin implements JsonSerializable {
  final int id;
  final String nameDoctor;
  final String category;
  final double rate;
  final int count;
  final String image;
  final int views;
  final int experiences;
  final String available;
  final int price;

  DoctorDataModel(
      {required this.id,
      required this.nameDoctor,
      required this.category,
      required this.rate,
      required this.count,
      required this.image,
      required this.views,
      required this.experiences,
      required this.available,
      required this.price});
  factory DoctorDataModel.fromMap(Map<String, dynamic> map) {
    return DoctorDataModel(
        id: map["id"] ?? 0,
        nameDoctor: map["nameDoctor"] ?? "error",
        category: map["category"] ?? "error",
        rate: map["rate"] ?? 5,
        count: map["count"] ?? 0,
        image: map["image"] ?? "error",
        views: map["views"] ?? 0,
        experiences: map["experiences"] ?? 0,
        available: map["available"] ?? "16:30:04",
        price: map["price"] ?? 100);
  }
  @override
  List<Object?> get props => [];
}
