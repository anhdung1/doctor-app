part of 'logout_bloc.dart';

abstract class LogoutState {}

class LogoutSuccessState extends LogoutState {}

class LogoutFailureState extends LogoutState {}

class LogoutLoadingState extends LogoutState {}

class LogoutInitialState extends LogoutState {}
