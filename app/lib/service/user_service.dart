import 'dart:convert';
import 'dart:developer';
import 'package:app/http_error_code.dart';
import 'package:app/model/user_data_model.dart';
import 'package:app/service/api_service.dart';
import 'package:app/service/result.dart';
import 'package:http/http.dart';

class UserService {
  static Future<Result> getInformation() async {
    try {
      Response response = await ApiService.getMapping("user_information");
      if (response.statusCode == 200) {
        UserDataModel user = UserDataModel.fromMap(
            jsonDecode(utf8.decode(response.bodyBytes))
                as Map<String, dynamic>);
        return Result(data: user);
      } else {
        return Result(error: "error: ${getErrorMessage(response.statusCode)}");
      }
    } catch (e) {
      log(e.toString());
      return Result(error: e.toString());
    }
  }

  static Future<Result> putInformation(UserDataModel user) async {
    try {
      Response response =
          await ApiService.putMapping("user_information", user.toJson());
      if (response.statusCode == 200) {
        UserDataModel user = UserDataModel.fromMap(
            jsonDecode(utf8.decode(response.bodyBytes))
                as Map<String, dynamic>);
        return Result(data: user);
      } else {
        return Result(error: "error: ${getErrorMessage(response.statusCode)}");
      }
    } catch (e) {
      log(e.toString());
      return Result(error: e.toString());
    }
  }
}
