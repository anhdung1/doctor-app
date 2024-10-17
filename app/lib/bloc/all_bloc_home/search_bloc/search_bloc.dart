import 'dart:async';

import 'package:app/bloc/all_bloc_home/search_bloc/search_event.dart';
import 'package:app/bloc/all_bloc_home/search_bloc/search_state.dart';
import 'package:app/service/result.dart';
import 'package:app/service/search_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
