import 'package:app/layers/domain/entities/appointment_data_model.dart';
import 'package:app/layers/domain/service/api_service.dart';
import 'package:app/layers/domain/service/result.dart';
import 'package:app/layers/presentation/views/constants/http_error_code.dart';
import 'package:http/http.dart';

class AppointmentService {
  static Future<Result> getAppointment(int doctorId) {
    return ApiService.jsonHandleGetMapping(
        AppointmentDataModel.fromMap, "appointment?doctorId=$doctorId");
  }

  static Future<Result> updatePatient(int appointmentId) async {
    try {
      Response response =
          ApiService.patchMapping("appointment/$appointmentId", {});
      if (response.statusCode == 200) {
        return Result(data: "Success");
      }
      return Result(error: getErrorMessage(response.statusCode));
    } catch (e) {
      return Result(error: e.toString());
    }
  }
}
