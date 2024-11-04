part of 'profile_bloc.dart';

abstract class ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  final UserDataModel user;

  ProfileSuccessState({required this.user});
}

class ProfileUpdateSuccessState extends ProfileState {
  final UserDataModel user;

  ProfileUpdateSuccessState({required this.user});
}

class ProfileErrorState extends ProfileState {
  final String error;

  ProfileErrorState({required this.error});
}
