import 'package:app/model/doctors_dto_data_model.dart';
import 'package:equatable/equatable.dart';

abstract class FavoriteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteInitialState extends FavoriteState {}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteSuccessState extends FavoriteState {
  final List<DoctorsDtoDataModel> doctorsDTO;

  FavoriteSuccessState({required this.doctorsDTO});
  @override
  List<Object?> get props => [doctorsDTO];
}

class FavoriteFailureState extends FavoriteState {
  final String error;

  FavoriteFailureState({required this.error});
  @override
  List<Object?> get props => [error];
}
