part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  final List<DoctorsDtoDataModel> doctorsDTO;

  SearchSuccessState({required this.doctorsDTO});
}

class SearchFailureState extends SearchState {
  final String error;

  SearchFailureState({required this.error});
  @override
  List<Object?> get props => [error];
}
