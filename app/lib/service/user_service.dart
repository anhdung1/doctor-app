import 'dart:convert';
import 'package:app/model/user_data_model.dart';
import 'package:app/service/api_service.dart';
import 'package:http/http.dart';

class UserService {
  static Future getInformation() async {
    Response response = await ApiService.getMapping("user_information");
    return UserDataModel.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>);
  }

  static Future putInformation(UserDataModel user) async {
    Response response =
        await ApiService.putMapping("user_information", user.toJson());
    return UserDataModel.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>);
  }
}
