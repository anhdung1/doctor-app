import 'package:app/service/api_service.dart';

class UserService {
  static Future getInformation() {
    return ApiService.getMapping("/user_information");
  }
}
