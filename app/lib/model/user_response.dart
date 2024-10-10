import 'package:app/service/json_serializable.dart';

class UserRespone implements JsonSerializable {
  final String token;
  final String image;
  final String firstName;
  final String lastName;
  final String username;

  UserRespone(
      {required this.token,
      required this.image,
      required this.firstName,
      required this.lastName,
      required this.username});
  factory UserRespone.toMap(Map<String, dynamic> map) {
    return UserRespone(
        token: map['token'] ?? "",
        image: map['image'] ?? "",
        firstName: map['firstName'] ?? "Your Name",
        lastName: map['lastName'] ?? "",
        username: map['username'] ?? "");
  }
}
