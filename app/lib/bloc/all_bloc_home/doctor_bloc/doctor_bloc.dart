import 'dart:async';

import 'package:app/bloc/all_bloc_home/doctor_bloc/doctor_event.dart';
import 'package:app/bloc/all_bloc_home/doctor_bloc/doctor_state.dart';
import 'package:app/model/doctors_dto_data_model.dart';
import 'package:app/service/doctor_service.dart';
import 'package:app/service/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  DoctorBloc() : super(DoctorLoadingState()) {
    on<DoctorStarted>(_fetchingDoctor);
    on<DoctorGetAllEvent>(_fetchingAllDoctor);
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

  FutureOr<void> _fetchingAllDoctor(
      DoctorGetAllEvent event, Emitter<DoctorState> emit) async {
    try {
      Result<List<DoctorsDtoDataModel>> doctors =
          await DoctorService.fetchingAllDoctor();
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
