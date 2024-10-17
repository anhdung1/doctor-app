import 'dart:async';

import 'package:app/bloc/login_bloc/login_event.dart';
import 'package:app/bloc/login_bloc/login_state.dart';
import 'package:app/model/user_response.dart';
import 'package:app/network/check_internet.dart';
import 'package:app/service/login_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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
      var result = await loginService.login(event.username, event.password);

      if (result is UserResponse) {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(result.token);

        if (decodedToken['role'] == "ADMIN") {
          return emit(LoginAdminSuccessState());
        }
        if (decodedToken['role'] == "USER") {
          return emit(LoginUserSuccessState(login: result));
        }
        if (decodedToken['role'] == "DOCTOR") {
          return emit(LoginDoctorSuccessState(login: result));
        }
      }

      if (result is String) {
        emit(LoginFailureState(error: result));
      }
    }
  }

  FutureOr<void> _showSignUpPageEvent(
      ShowSignUpPageEvent event, Emitter<LoginState> emit) {
    emit(SigupState());
  }
}
