import 'dart:async';

import 'package:app/layers/domain/entities/appointment_data_model.dart';
import 'package:app/layers/presentation/blocs/appointment_bloc/appointment_event.dart';
import 'package:app/layers/presentation/blocs/appointment_bloc/appointment_state.dart';
import 'package:app/layers/domain/service/appointment_service.dart';
import 'package:app/layers/domain/service/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc() : super(AppointmentLoadingState()) {
    on<AppointmentStartedEvent>(_getAppointment);
    on<AppointmentUpdateEvent>(_updateAppointment);
  }

  FutureOr<void> _getAppointment(
      AppointmentStartedEvent event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoadingState());
    Result result = await AppointmentService.getAppointment(event.doctorId);
    if (result.isSuccess) {
      List<AppointmentDataModel> appointments = result.data;
      print(appointments[0].appointmentDate);
      return emit(AppointmentSuccessState(appointments: result.data));
    }
    return emit(AppointmentFailureState(error: result.error ?? "Unknow error"));
  }

  FutureOr<void> _updateAppointment(
      AppointmentUpdateEvent event, Emitter<AppointmentState> emit) async {
    Result result = await AppointmentService.updatePatient(event.appointmentId);
    if (result.isSuccess) {
      return;
    }
  }
}
