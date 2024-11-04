import 'package:app/layers/domain/service/json_serializable.dart';
import 'package:intl/intl.dart';

class AppointmentDataModel extends JsonSerializable {
  final String appointmentTime;
  final int id;
  final DateTime appointmentDate;
  AppointmentDataModel(
      {required this.appointmentTime,
      required this.id,
      required this.appointmentDate});
  factory AppointmentDataModel.fromMap(Map<String, dynamic> map) {
    return AppointmentDataModel(
        appointmentTime: map["appointmentTime"] ?? "00:00:00",
        id: map["id"] ?? true,
        appointmentDate:
            DateTime.parse(map["appointmentDate"] ?? "2099-12-31"));
  }
}
