import 'package:app/layers/domain/entities/doctor_data_model.dart';
import 'package:app/layers/domain/service/json_serializable.dart';
import 'package:equatable/equatable.dart';

class DoctorsDtoDataModel extends JsonSerializable with EquatableMixin {
  final DoctorDataModel doctors;
  final bool isFavorite;
  set isFavorite(bool value) => isFavorite = value;
  DoctorsDtoDataModel({required this.doctors, required this.isFavorite});
  factory DoctorsDtoDataModel.fromMap(Map<String, dynamic> map) {
    return DoctorsDtoDataModel(
        doctors: DoctorDataModel.fromMap(map['doctors']),
        isFavorite: map["favorite"] ?? false);
  }

  @override
  List<Object?> get props => [doctors, isFavorite];
}
