import 'package:app/bloc/login_bloc/login_bloc.dart';

abstract class LoginEvent {}

class LoginCheckEvent extends LoginEvent {
  final String username;
  final String password;
  final LoginBloc parentBloc;
  LoginCheckEvent(
      {required this.username,
      required this.password,
      required this.parentBloc});
}

class ShowSignUpPageEvent extends LoginEvent {}
