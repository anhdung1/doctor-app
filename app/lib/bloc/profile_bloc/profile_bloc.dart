import 'dart:async';

import 'package:app/bloc/profile_bloc/profile_event.dart';
import 'package:app/bloc/profile_bloc/profile_state.dart';
import 'package:app/service/result.dart';
import 'package:app/service/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoadingState()) {
    on<ProfileFetchingEvent>(_fetchingUser);
    on<ProfileEditEvent>(_editInfomation);
  }

  FutureOr<void> _fetchingUser(
      ProfileFetchingEvent event, Emitter<ProfileState> emit) async {
    Result isSuccess = await UserService.getInformation();

    if (isSuccess.isSuccess) {
      emit(ProfileSuccessState(user: isSuccess.data));
    } else {
      emit(ProfileErrorState(error: isSuccess.error ?? ""));
    }
  }

  FutureOr<void> _editInfomation(
      ProfileEditEvent event, Emitter<ProfileState> emit) async {
    Result isSuccess = await UserService.putInformation(event.user);

    if (isSuccess.isSuccess) {
      emit(ProfileUpdateSuccessState(user: isSuccess.data));
    } else {
      emit(ProfileErrorState(error: isSuccess.error ?? ""));
    }
  }
}
