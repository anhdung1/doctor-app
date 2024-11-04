import 'dart:async';

import 'package:app/layers/domain/service/logout_service.dart';
import 'package:app/layers/domain/service/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'logout_state.dart';
part 'logout_event.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitialState()) {
    on<LogoutCheckEvent>(_logout);
  }

  FutureOr<void> _logout(
      LogoutCheckEvent event, Emitter<LogoutState> emit) async {
    emit(LogoutLoadingState());
    await LogoutService.logout();
    await removeId();
    await removeToken();
    emit(LogoutSuccessState());
  }
}
