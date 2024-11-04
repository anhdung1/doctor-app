import 'dart:async';

import 'package:app/layers/domain/entities/doctors_dto_data_model.dart';
import 'package:app/layers/domain/service/result.dart';
import 'package:app/layers/domain/service/search_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'search_state.dart';
part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitialState()) {
    on<SearchFetchingEvent>(_fetchingDoctors);
  }

  FutureOr<void> _fetchingDoctors(
      SearchFetchingEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    Result doctors = await SearchService.fetchingDoctor(event.content);
    if (doctors.isSuccess) {
      if (doctors.data.isNotEmpty) {
        return emit(SearchSuccessState(doctorsDTO: doctors.data));
      }
      return emit(
          SearchFailureState(error: "The requested doctor could not be found"));
    }
    emit(SearchFailureState(error: doctors.error ?? ""));
  }
}
