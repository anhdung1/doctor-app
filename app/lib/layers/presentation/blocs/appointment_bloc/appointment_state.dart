import 'package:app/layers/domain/entities/appointment_data_model.dart';

abstract class AppointmentState {}

class AppointmentLoadingState extends AppointmentState {}

class AppointmentSuccessState extends AppointmentState {
  final List<AppointmentDataModel> appointments;

  AppointmentSuccessState({required this.appointments});
}

class AppointmentFailureState extends AppointmentState {
  final String error;

  AppointmentFailureState({required this.error});
}
