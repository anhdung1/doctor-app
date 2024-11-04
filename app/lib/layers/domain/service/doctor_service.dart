import 'package:app/layers/domain/entities/doctors_dto_data_model.dart';
import 'package:app/layers/domain/service/api_service.dart';
import 'package:app/layers/domain/service/result.dart';

class DoctorService {
  static Future<Result<List<DoctorsDtoDataModel>>>
      fetchingRandomDoctor() async {
    Result<List<DoctorsDtoDataModel>> result =
        await ApiService.jsonHandleGetMapping(
            DoctorsDtoDataModel.fromMap, "doctors");
    return result;
  }
}
