import 'package:app/layers/domain/entities/base_enity.dart';
import 'package:app/layers/domain/service/json_serializable.dart';

class UserDataModel extends BaseEntity implements JsonSerializable {
  final String lastName;
  final String firstName;
  final String phoneNumber;

  final String email;
  final String address;

  UserDataModel({
    required this.lastName,
    required this.firstName,
    required this.phoneNumber,
    required super.image,
    required this.email,
    required this.address,
    required super.id,
  });
  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
        lastName: map["lastName"] ?? "",
        firstName: map["firstName"] ?? "",
        phoneNumber: map["phoneNumber"] ?? "",
        image: map["image"] ?? "",
        email: map["email"] ?? "",
        address: map["address"] ?? "",
        id: map["userId"] ?? -1);
  }
  Map<String, dynamic> toJson() {
    return {
      'lastName': lastName,
      'firstName': firstName,
      'phoneNumber': phoneNumber,
      "image": image,
      "email": email,
      "address": address
    };
  }
}
