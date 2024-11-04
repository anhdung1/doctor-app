part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpLoadingState extends SignupState {}

class SignUpInitalState extends SignupState {}

class SignUpSuccessState extends SignupState {}

class SignUpFailureState extends SignupState {
  final String error;

  SignUpFailureState({required this.error});
  @override
  List<Object?> get props => [error];
}

class SendSignUpSuccessState extends SignupState {
  final bool showNotify;

  SendSignUpSuccessState({required this.showNotify});
}

class ShowLoginState extends SignupState {}
