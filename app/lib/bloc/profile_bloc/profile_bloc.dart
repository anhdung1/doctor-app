import 'dart:async';

import 'package:app/bloc/profile_bloc/profile_event.dart';
import 'package:app/bloc/profile_bloc/profile_state.dart';
import 'package:app/model/user_data_model.dart';
import 'package:app/service/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoadingState()) {
    on<ProfileFetchingEvent>(_fetchingUser);
    on<ProfileEditEvent>(_editInfomation);
  }

  FutureOr<void> _fetchingUser(
      ProfileFetchingEvent event, Emitter<ProfileState> emit) async {
    var isSuccess = await UserService.getInformation();

    if (isSuccess is UserDataModel) {
      emit(ProfileSuccessState(user: isSuccess));
    } else {
      emit(ProfileErrorState(error: isSuccess));
    }
  }

  FutureOr<void> _editInfomation(
      ProfileEditEvent event, Emitter<ProfileState> emit) async {
    var isSuccess = await UserService.putInformation(event.user);

    if (isSuccess is UserDataModel) {
      emit(ProfileUpdateSuccessState(user: isSuccess));
    } else {
      emit(ProfileErrorState(error: isSuccess));
    }
  }
}
