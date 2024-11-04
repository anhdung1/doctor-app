part of 'user_chatted_bloc.dart';

abstract class UserChattedState {}

class UserChattedLoadingState extends UserChattedState {}

class UserChattedSuccessState extends UserChattedState {
  final List<DoctorDataModel> listDoctors;

  UserChattedSuccessState({required this.listDoctors});
}

class UserChattedOfDoctorSuccessState extends UserChattedState {
  final List<UserDataModel> listUser;

  UserChattedOfDoctorSuccessState({required this.listUser});
}

class UserChattedFailureState extends UserChattedState {
  final String error;

  UserChattedFailureState({required this.error});
}
