import 'dart:async';

import 'package:app/layers/domain/entities/doctors_dto_data_model.dart';
import 'package:app/layers/domain/service/doctor_service.dart';
import 'package:app/layers/domain/service/result.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'doctor_event.dart';
part 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  DoctorBloc() : super(DoctorLoadingState()) {
    on<DoctorStarted>(_fetchingDoctor);
  }

  FutureOr<void> _fetchingDoctor(
      DoctorStarted event, Emitter<DoctorState> emit) async {
    try {
      Result doctors = await DoctorService.fetchingRandomDoctor();
      if (doctors.isSuccess) {
        emit(DoctorSuccessState(doctorsDTO: doctors.data ?? []));
      } else {
        emit(DoctorFailureState());
      }
    } catch (e) {
      return emit(DoctorFailureState());
    }
  }
}
