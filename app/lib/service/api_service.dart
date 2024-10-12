import 'dart:convert';
import 'dart:developer';

import 'package:app/http_error_code.dart';
import 'package:app/service/json_serializable.dart';
import 'package:app/service/json_to_list.dart';
import 'package:app/service/token.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Map<String, String> headers(token) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  static final client = http.Client();
  static getMapping(String url) async {
    return await client.get(Uri.parse("http://localhost:8080/$url"),
        headers: headers(await getToken()));
  }

  static postMapping(String url, body) async {
    return await client.post(Uri.parse("http://localhost:8080/$url"),
        headers: headers(await getToken()), body: jsonEncode(body));
  }

  static putMapping(String url, body) async {
    return await client.put(Uri.parse("http://localhost:8080/$url"),
        headers: headers(await getToken()), body: jsonEncode(body));
  }

  static Future jsonHandlePutMapping<T extends JsonSerializable>(
      T Function(Map<String, dynamic>) fromMap, String url, body) async {
    try {
      var response = await ApiService.putMapping(url, body);
      if (response.statusCode == 200) {
        return JsonToListService.jsonToList(response, fromMap);
      } else {
        return "Failed to load data: ${getErrorMessage(response.statusCode)}";
      }
    } catch (e) {
      log("Error occurred: $e");
      return ("Error fetching data");
    }
  }

  static Future jsonHandleGetMapping<T extends JsonSerializable>(
      T Function(Map<String, dynamic>) fromMap, String url) async {
    try {
      var response = await ApiService.getMapping(url);

      if (response.statusCode == 200) {
        return JsonToListService.jsonToList(response, fromMap);
      } else {
        return "Failed to load data: ${getErrorMessage(response.statusCode)}";
      }
    } catch (e) {
      log("Error occurred: $e");
      return ("Error fetching data");
    }
  }

  static Future jsonHandlePostMapping<T extends JsonSerializable>(
      T Function(Map<String, dynamic>) fromMap, String url, body) async {
    try {
      var response = await ApiService.postMapping(url, body);
      if (response.statusCode == 200) {
        return JsonToListService.jsonToList(response, fromMap);
      } else {
        return "Failed to load data: ${getErrorMessage(response.statusCode)}";
      }
    } catch (e) {
      log("Error occurred: $e");
      return ("Error fetching data");
    }
  }
}
