part of 'favorite_bloc.dart';

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
