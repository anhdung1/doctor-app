import 'dart:convert';
import 'package:app/service/json_serializable.dart';
import 'package:http/http.dart' as http;

class JsonToListService {
  static Future<List<T>> jsonToList<T extends JsonSerializable>(
      http.Response response, T Function(Map<String, dynamic>) fromMap) async {
    List<dynamic> result = jsonDecode(response.body);

    List<T> dataList = [];

    for (int i = 0; i < result.length; i++) {
      var item = fromMap(result[i] as Map<String, dynamic>);
      dataList.add(item);
    }
    return dataList;
  }
}
