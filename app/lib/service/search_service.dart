import 'package:app/model/doctors_dto_data_model.dart';
import 'package:app/service/api_service.dart';

class SearchService {
  static Future fetchingDoctor(String content) async {
    return await ApiService.jsonHandleGetMapping(
        DoctorsDtoDataModel.fromMap, "doctors/search?category=$content");
  }
}
