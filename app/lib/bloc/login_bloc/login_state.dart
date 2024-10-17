import 'package:app/model/user_response.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginAdminSuccessState extends LoginState {}

class LoginUserSuccessState extends LoginState {
  final UserResponse login;

  LoginUserSuccessState({required this.login});
}

class LoginDoctorSuccessState extends LoginState {
  final UserResponse login;

  LoginDoctorSuccessState({required this.login});
}

class LoginFailureState extends LoginState {
  final String error;

  LoginFailureState({required this.error});
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class SigupState extends LoginState {}
