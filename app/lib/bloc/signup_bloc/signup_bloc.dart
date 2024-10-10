import 'dart:async';

import 'package:app/bloc/signup_bloc/signup_event.dart';
import 'package:app/bloc/signup_bloc/signup_state.dart';
import 'package:app/service/signup_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignUpInitalState()) {
    on<SignUpCheckEvent>(_signUp);
    on<ShowLoginEvent>(_showLogin);
    on<BackSignUpEvent>(_backSignUp);
    on<SendSignUpEvent>(_sendSignUp);
  }
  FutureOr<void> _signUp(
      SignUpCheckEvent event, Emitter<SignupState> emit) async {
    if (!_isRegisterValid(event, emit)) return;
    SignupService signupService = SignupService();
    try {
      var isSuccess =
          await signupService.checkUsername(event.password, event.username);
      if (isSuccess == true) {
        emit(SignUpSuccessState());
      } else {
        _handleError(emit, isSuccess ?? "Unknown error occurred");
      }
    } catch (e) {
      _handleError(emit, "An error occurred: ${e.toString()}");
    }
  }

  void _handleError(Emitter<SignupState> emit, String error) {
    emit(SignUpFailureState(error: error));
  }

  bool _isRegisterValid(SignUpCheckEvent event, Emitter<SignupState> emit) {
    if (event.password != event.reEnterPassword) {
      emit(SignUpFailureState(error: "Password do not match"));
      return false;
    }

    if (event.username.length < 6) {
      emit(SignUpFailureState(
          error: "Username must be greater than 6 characters"));
      return false;
    }

    if (event.password.isEmpty) {
      emit(SignUpFailureState(error: "Please fill in complete information"));
      return false;
    }

    if (!event.agreeCondition) {
      emit(SignUpFailureState(
          error:
              "You must accept the Terms of Service & Privacy Policy to continue"));
      return false;
    }

    return true;
  }

  FutureOr<void> _showLogin(ShowLoginEvent event, Emitter<SignupState> emit) {
    emit(ShowLoginState());
  }

  FutureOr<void> _backSignUp(BackSignUpEvent event, Emitter<SignupState> emit) {
    emit(SignUpInitalState());
  }

  FutureOr<void> _sendSignUp(
      SendSignUpEvent event, Emitter<SignupState> emit) async {
    emit(SignUpLoadingState());
    SignupService service = SignupService();
    try {
      var isSuccess = await service.signUp(event.password, event.username);
      if (isSuccess == true) {
        return emit(SendSignUpSuccessState(showNotify: true));
      }
    } catch (e) {
      debugPrint("$e");
    }
  }
}
