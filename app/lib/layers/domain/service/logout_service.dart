import 'package:app/layers/domain/service/api_service.dart';
import 'package:app/layers/domain/service/result.dart';

class LogoutService {
  static Future<Result> logout() async {
    try {
      await ApiService.postMapping("api/auth/logout", {});
      return Result();
    } catch (e) {
      return Result();
    }
  }
}
