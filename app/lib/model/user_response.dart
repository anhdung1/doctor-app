import 'package:app/service/json_serializable.dart';

class UserResponse implements JsonSerializable {
  final String token;
  final String image;
  final String firstName;
  final String lastName;
  final String username;

  UserResponse(
      {required this.token,
      required this.image,
      required this.firstName,
      required this.lastName,
      required this.username});
  factory UserResponse.toMap(Map<String, dynamic> map) {
    return UserResponse(
        token: map['token'] ?? "",
        image: map['image'] ?? "",
        firstName: map['firstName'] ?? "",
        lastName: map['lastName'] ?? "",
        username: map['username'] ?? "");
  }
}
