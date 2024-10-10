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
  factory UserDataModel.fromJson(Map<String, dynamic> map) {
    return UserDataModel(
        lastName: map["lastName"] ?? "",
        firstName: map["lastName"] ?? "",
        id: map["lastName"] ?? -1,
        phoneNumber: map["lastName"] ?? "",
        image: map["lastName"] ?? "",
        email: map["lastName"] ?? "",
        address: map["lastName"] ?? "");
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lastname': lastName,
      'firstname': firstName,
      'phoneNumber': phoneNumber,
      "image": image,
      "email": email,
      "address": address
    };
  }
}
