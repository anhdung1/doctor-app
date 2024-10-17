import 'dart:async';

import 'package:app/bloc/all_bloc_favorite/favorite_bloc/favorite_event.dart';
import 'package:app/bloc/all_bloc_favorite/favorite_bloc/favorite_state.dart';
import 'package:app/model/doctors_dto_data_model.dart';

import 'package:app/service/favorite_service.dart';
import 'package:app/service/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final List<DoctorsDtoDataModel> doctors;
  FavoriteBloc(this.doctors) : super(FavoriteInitialState()) {
    on<FavoriteStartedEvent>(_onfetching);
    on<FavoriteEditEvent>(_editFavorite);
    on<FavoriteUpdateEvent>(_updateFavorite);
  }

  FutureOr<void> _onfetching(
      FavoriteStartedEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());
    Result dataFavorite = await FavoriteService.fetchingDoctorFavorite();
    if (dataFavorite.isSuccess) {
      doctors.clear();
      doctors.addAll(dataFavorite.data);
      if (doctors.isEmpty) {
        return emit(FavoriteFailureState(
            error: "You don't have a favorite doctor yet"));
      }
      return emit(FavoriteSuccessState(doctorsDTO: doctors));
    } else {
      return emit(FavoriteFailureState(error: dataFavorite.error ?? ""));
    }
  }

  FutureOr _editFavorite(
      FavoriteEditEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());
    Result isSuccess = await FavoriteService.updateDoctorFavorite(
        event.doctorId, event.isFavorite);

    if (isSuccess.isSuccess) {
      int index =
          doctors.indexWhere((doctor) => doctor.doctors.id == event.doctorId);
      if (index == -1) {
        doctors.add(isSuccess.data);
      } else {
        doctors.removeAt(index);
      }
      if (doctors.isEmpty) {
        return emit(FavoriteFailureState(
            error: "You don't have a favorite doctor yet"));
      } else {
        emit(FavoriteSuccessState(doctorsDTO: doctors));
      }
    } else {
      return emit(FavoriteFailureState(error: isSuccess.error ?? ""));
    }
  }

  FutureOr<void> _updateFavorite(
      FavoriteUpdateEvent event, Emitter<FavoriteState> emit) {
    emit(FavoriteLoadingState());
    emit(FavoriteSuccessState(doctorsDTO: doctors));
  }
}
