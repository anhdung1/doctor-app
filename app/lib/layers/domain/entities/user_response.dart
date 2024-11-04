import 'package:app/layers/domain/entities/user_data_model.dart';
import 'package:app/layers/domain/service/json_serializable.dart';

class UserResponse implements JsonSerializable {
  final String token;
  final UserDataModel userInfo;
  UserResponse({required this.token, required this.userInfo});
  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
        token: map['token'] ?? "",
        userInfo: UserDataModel.fromMap(map["userInfo"]));
  }
}
