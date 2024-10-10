import 'package:app/model/doctors_dto_data_model.dart';
import 'package:app/service/api_service.dart';

class DoctorService {
  static Future<List<DoctorsDtoDataModel>> fetchingRandomDoctor() async {
    return await ApiService.jsonHandleGetMapping(
        DoctorsDtoDataModel.fromMap, "doctors");
  }
}
