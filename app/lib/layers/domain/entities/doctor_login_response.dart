import 'package:app/layers/domain/entities/doctor_data_model.dart';
import 'package:app/layers/domain/service/json_serializable.dart';

class DoctorLoginResponse implements JsonSerializable {
  final String token;
  final DoctorDataModel doctor;

  DoctorLoginResponse({required this.token, required this.doctor});
  factory DoctorLoginResponse.fromMap(Map<String, dynamic> map) {
    return DoctorLoginResponse(
      token: map['token'] ?? "",
      doctor: DoctorDataModel.fromMap(map["doctor"]),
    );
  }
}
