import 'package:app/service/json_serializable.dart';

class UserDataModel implements JsonSerializable {
  final String lastName;
  final String firstName;
  final int id;
  final String phoneNumber;
  final String image;
  final String email;
  final String address;

  UserDataModel(
      {required this.lastName,
      required this.firstName,
      required this.id,
      required this.phoneNumber,
      required this.image,
      required this.email,
      required this.address});
  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
        lastName: map["lastName"] ?? "",
        firstName: map["firstName"] ?? "",
        id: map["id"] ?? -1,
        phoneNumber: map["phoneNumber"] ?? "",
        image: map["image"] ?? "",
        email: map["email"] ?? "",
        address: map["address"] ?? "");
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'lastName': lastName,
      'firstName': firstName,
      'phoneNumber': phoneNumber,
      "image": image,
      "email": email,
      "address": address
    };
  }
}
