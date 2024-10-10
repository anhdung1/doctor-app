import 'package:app/model/user_data_model.dart';

abstract class ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  final UserDataModel user;

  ProfileSuccessState({required this.user});
}

class ProfileErrorState extends ProfileState {
  final String error;

  ProfileErrorState({required this.error});
}
