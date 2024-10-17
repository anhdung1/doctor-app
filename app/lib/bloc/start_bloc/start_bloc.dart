import 'package:app/bloc/start_bloc/start_event.dart';
import 'package:app/bloc/start_bloc/start_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartBloc extends Bloc<StartEvent, StartState> {
  StartBloc(super.initialState) {
    on<StartContinueEvent>(
      (event, emit) {
        if (event.count < 2) {
          return emit(
              StartPageState(start: event.startModel, count: event.count + 1));
        }
        return emit(StartNextLogin());
      },
    );
  }
}
