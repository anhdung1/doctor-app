import 'package:app/layers/domain/entities/start_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'start_state.dart';
part 'start_event.dart';

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
