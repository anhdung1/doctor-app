import 'dart:async';

import 'package:app/layers/domain/entities/user_data_model.dart';
import 'package:app/layers/domain/service/result.dart';
import 'package:app/layers/domain/service/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'profile_state.dart';
part 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoadingState()) {
    on<ProfileFetchingEvent>(_fetchingUser);
    on<ProfileEditEvent>(_editInfomation);
  }

  FutureOr<void> _fetchingUser(
      ProfileFetchingEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    Result isSuccess = await UserService.getInformation();

    if (isSuccess.isSuccess) {
      emit(ProfileSuccessState(user: isSuccess.data));
    } else {
      emit(ProfileErrorState(error: isSuccess.error ?? ""));
    }
  }

  FutureOr<void> _editInfomation(
      ProfileEditEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    Result isSuccess = await UserService.putInformation(event.user);

    if (isSuccess.isSuccess) {
      emit(ProfileUpdateSuccessState(user: isSuccess.data));
    } else {
      emit(ProfileErrorState(error: isSuccess.error ?? ""));
    }
  }
}
