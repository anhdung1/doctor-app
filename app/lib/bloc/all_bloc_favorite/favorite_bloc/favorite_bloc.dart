import 'dart:async';

import 'package:app/bloc/all_bloc_favorite/favorite_bloc/favorite_event.dart';
import 'package:app/bloc/all_bloc_favorite/favorite_bloc/favorite_state.dart';
import 'package:app/model/doctors_dto_data_model.dart';

import 'package:app/service/favorite_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final List<DoctorsDtoDataModel> doctors;
  FavoriteBloc(this.doctors) : super(FavoriteInitialState()) {
    on<FavoriteStartedEvent>(_onfetching);
    on<FavoriteEditEvent>(_editFavorite);
  }

  FutureOr<void> _onfetching(
      FavoriteStartedEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());
    var dataFavorite = await FavoriteService.fetchingDoctorFavorite();
    if (dataFavorite is List<DoctorsDtoDataModel>) {
      doctors.clear();
      doctors.addAll(dataFavorite);
      if (doctors.isEmpty) {
        return emit(FavoriteFailureState(
            error: "You don't have a favorite doctor yet"));
      }
      return emit(FavoriteSuccessState(doctorsDTO: doctors));
    } else {
      return emit(FavoriteFailureState(error: dataFavorite ?? ""));
    }
  }

  FutureOr<void> _editFavorite(
      FavoriteEditEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());
    var isSuccess = await FavoriteService.updateDoctorFavorite(
        event.doctorId, event.isFavorite);
    if (isSuccess is DoctorsDtoDataModel) {
      int index =
          doctors.indexWhere((doctor) => doctor.doctors.id == event.doctorId);
      if (index != -1 && isSuccess.isFavorite == false) {
        doctors.removeAt(index);
      } else {
        doctors.add(isSuccess);
      }
      if (doctors.isEmpty) {
        return emit(FavoriteFailureState(
            error: "You don't have a favorite doctor yet"));
      } else {
        emit(FavoriteSuccessState(doctorsDTO: doctors));
      }
    } else {
      return emit(FavoriteFailureState(error: isSuccess ?? ""));
    }
  }
}
