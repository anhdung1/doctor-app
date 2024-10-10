import 'dart:convert';
import 'dart:developer';
import 'package:app/http_error_code.dart';
import 'package:app/model/user_response.dart';
import 'package:app/service/token.dart';
import 'package:http/http.dart' as http;

class LoginService {
  final String _baseUrl = 'http://localhost:8080/api/auth'; // Địa chỉ của API

  Future login(String username, String password) async {
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
        UserRespone login = UserRespone.toMap(
            jsonDecode(response.body) as Map<String, dynamic>);
        saveToken(login.token);

        return login;
      } else if (response.statusCode == 401) {
        return response.body;
      }
      {
        return getErrorMessage(response.statusCode);
      }
    } catch (e) {
      log('An error occurred during login: $e');
      return "$e";
    }
  }
}
