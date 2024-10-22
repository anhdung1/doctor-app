import 'package:app/model/user_data_model.dart';
import 'package:app/service/json_serializable.dart';

class UserResponse implements JsonSerializable {
  final String token;
  final UserDataModel userInfo;
  UserResponse({required this.token, required this.userInfo});
  factory UserResponse.toMap(Map<String, dynamic> map) {
    return UserResponse(
        token: map['token'] ?? "",
        userInfo: UserDataModel.fromMap(map["userInfo"]));
  }
}
