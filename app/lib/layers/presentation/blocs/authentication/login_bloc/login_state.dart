part of 'login_bloc.dart';

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
  final DoctorLoginResponse login;

  LoginDoctorSuccessState({required this.login});
}

class LoginFailureState extends LoginState {
  final String error;

  LoginFailureState({required this.error});
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginMoveSigupState extends LoginState {}
