import 'dart:async';

import 'package:app/bloc/all_bloc_home/home_page_bloc/home_page_event.dart';
import 'package:app/bloc/all_bloc_home/home_page_bloc/home_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitialState(pageIndex: 0)) {
    on<HomePageRouteEvent>(_selectPage);
  }

  FutureOr<void> _selectPage(
      HomePageRouteEvent event, Emitter<HomePageState> emit) {
    emit(HomePageInitialState(pageIndex: event.index));
  }
}
