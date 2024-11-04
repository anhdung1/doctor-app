import 'dart:async';
import 'package:app/layers/domain/entities/doctor_login_response.dart';
import 'package:app/layers/domain/entities/user_response.dart';
import 'package:app/layers/data/source/network/check_internet.dart';
import 'package:app/layers/domain/service/login_service.dart';
import 'package:app/layers/domain/service/result.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginCheckEvent>(_login);
    on<ShowSignUpPageEvent>(_showSignUpPageEvent);
  }

  FutureOr<void> _login(LoginCheckEvent event, Emitter<LoginState> emit) async {
    bool checkInternet = await checkInternetConnection();

    if (checkInternet == false) {
      emit(LoginFailureState(error: "No internet"));
    } else {
      emit(LoginLoadingState());
      LoginService loginService = LoginService();
      Result result = await loginService.login(event.username, event.password);

      if (result.isSuccess) {
        if (result.data is DoctorLoginResponse) {
          return emit(LoginDoctorSuccessState(login: result.data));
        }
        if (result.data is UserResponse) {
          return emit(LoginUserSuccessState(login: result.data));
        }
      } else {
        emit(LoginFailureState(error: result.error ?? "unknow error"));
      }
    }
  }

  FutureOr<void> _showSignUpPageEvent(
      ShowSignUpPageEvent event, Emitter<LoginState> emit) {
    emit(LoginMoveSigupState());
  }
}
