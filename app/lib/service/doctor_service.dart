import 'package:app/model/doctors_dto_data_model.dart';
import 'package:app/service/api_service.dart';
import 'package:app/service/result.dart';

class DoctorService {
  static Future<Result<List<DoctorsDtoDataModel>>>
      fetchingRandomDoctor() async {
    Result<List<DoctorsDtoDataModel>> result =
        await ApiService.jsonHandleGetMapping(
            DoctorsDtoDataModel.fromMap, "doctors");
    return result;
  }

  static Future<Result<List<DoctorsDtoDataModel>>> fetchingAllDoctor() async {
    return await ApiService.jsonHandleGetMapping(
        DoctorsDtoDataModel.fromMap, "doctors/all-doctors");
  }
}
