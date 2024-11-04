import 'dart:convert';
import 'package:app/layers/domain/service/json_serializable.dart';
import 'package:http/http.dart' as http;

class JsonToObjectService {
  static List<T> jsonToList<T extends JsonSerializable>(
      http.Response response, T Function(Map<String, dynamic>) fromMap) {
    List result = jsonDecode(utf8.decode(response.bodyBytes));
    List<T> dataList = [];

    for (int i = 0; i < result.length; i++) {
      var item = fromMap(result[i] as Map<String, dynamic>);
      dataList.add(item);
    }
    return dataList;
  }

  static T jsonToObject<T extends JsonSerializable>(
      http.Response response, T Function(Map<String, dynamic>) fromMap) {
    var result = jsonDecode(utf8.decode(response.bodyBytes));

    var item = fromMap(result as Map<String, dynamic>);

    return item;
  }
}
