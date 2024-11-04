import 'dart:convert';
import 'dart:developer';

import 'package:app/layers/presentation/views/constants/http_error_code.dart';
import 'package:app/layers/domain/entities/doctors_dto_data_model.dart';
import 'package:app/layers/domain/service/api_service.dart';
import 'package:app/layers/domain/service/result.dart';
import 'package:http/http.dart';

class FavoriteService {
  static Future fetchingDoctorFavorite() async {
    return ApiService.jsonHandleGetMapping(
        DoctorsDtoDataModel.fromMap, "doctors/getfavorite");
  }

  static Future<Result<DoctorsDtoDataModel>> updateDoctorFavorite(
      int doctorId, bool isFavorite) async {
    try {
      Response response = await ApiService.postMapping(
          "doctors/updatefavorite?doctorId=$doctorId&isFavorite=$isFavorite",
          {});

      var result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        DoctorsDtoDataModel doctorsDto =
            DoctorsDtoDataModel.fromMap(result as Map<String, dynamic>);
        return Result(data: doctorsDto);
      } else {
        return Result(error: getErrorMessage(response.statusCode));
      }
    } catch (e) {
      log("error error: $e");
      return Result(error: "error error: $e");
    }
  }
}
