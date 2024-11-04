import 'dart:async';

import 'package:app/layers/domain/entities/doctor_data_model.dart';
import 'package:app/layers/domain/entities/user_data_model.dart';
import 'package:app/layers/domain/service/chat_service.dart';
import 'package:app/layers/domain/service/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_chatted_state.dart';
part 'user_chatted_event.dart';

class UserChattedBloc extends Bloc<UserChattedEvent, UserChattedState> {
  UserChattedBloc() : super(UserChattedLoadingState()) {
    on<UserChattedFetchingEvent>(_fetchingChattedUser);
  }

  FutureOr<void> _fetchingChattedUser(
      UserChattedFetchingEvent event, Emitter<UserChattedState> emit) async {
    Result result = await ChatService.fetchUserChatted();
    if (result.isSuccess) {
      if (result.data is List<DoctorDataModel>) {
        emit(UserChattedSuccessState(listDoctors: result.data));
      } else {
        emit(UserChattedOfDoctorSuccessState(listUser: result.data));
      }
    } else {
      emit(UserChattedFailureState(error: result.error ?? "Unknow error"));
    }
  }
}
