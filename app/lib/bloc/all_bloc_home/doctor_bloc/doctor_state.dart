import 'package:app/model/doctors_dto_data_model.dart';
import 'package:equatable/equatable.dart';

abstract class DoctorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DoctorLoadingState extends DoctorState {}

class DoctorFailureState extends DoctorState {}

class DoctorSuccessState extends DoctorState {
  final List<DoctorsDtoDataModel> doctorsDTO;

  DoctorSuccessState({required this.doctorsDTO});
  @override
  List<Object?> get props => [doctorsDTO];
}
