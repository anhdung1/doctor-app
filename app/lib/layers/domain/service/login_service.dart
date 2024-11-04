import 'dart:convert';

import 'package:app/layers/domain/entities/doctor_login_response.dart';
import 'package:app/layers/domain/service/result.dart';
import 'package:app/layers/presentation/views/constants/http_error_code.dart';
import 'package:app/layers/domain/entities/user_response.dart';
import 'package:app/layers/domain/service/token.dart';
import 'package:app/layers/presentation/views/constants/variable.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginService {
  final String _baseUrl = 'http://$ip:8080/api/auth'; // Địa chỉ của API

  Future<Result> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        var token = jsonDecode(response.body)["token"];
        String role = JwtDecoder.decode(token)["role"];

        saveToken(token);

        if (role == 'ROLE_USER') {
          UserResponse userResponse = UserResponse.fromMap(
              jsonDecode(utf8.decode(response.bodyBytes))
                  as Map<String, dynamic>);
          saveId(userResponse.userInfo.id);
          return Result(data: userResponse);
        }
        if (role == 'ROLE_DOCTOR') {
          DoctorLoginResponse doctorLoginResponse = DoctorLoginResponse.fromMap(
              jsonDecode(utf8.decode(response.bodyBytes))
                  as Map<String, dynamic>);
          saveId(doctorLoginResponse.doctor.id);
          return Result(data: doctorLoginResponse);
        }
      } else if (response.statusCode == 401) {
        return Result(error: response.body);
      }
      {
        return Result(error: getErrorMessage(response.statusCode));
      }
    } catch (e) {
      return Result(error: "$e");
    }
  }
}
