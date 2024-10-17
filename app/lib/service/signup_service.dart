import 'dart:convert';
import 'dart:developer';
import 'package:app/http_error_code.dart';
import 'package:app/views/variables/variable.dart';
import 'package:http/http.dart' as http;

class SignupService {
  final String _baseUrl = 'http://$ip:8080/api/auth';
  Future checkUsername(String password, String username) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/check-username'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 409) {
        return response.body;
      } else {
        return getErrorMessage(response.statusCode);
      }
    } catch (e) {
      log('An error occurred during login: $e');
      return "$e";
    }
  }

  Future signUp(String password, String username) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/signup'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );
    try {
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 409) {
        return response.body;
      } else {
        return getErrorMessage(response.statusCode);
      }
    } catch (e) {
      log('An error occurred during login: $e');
      return "$e";
    }
  }
}
