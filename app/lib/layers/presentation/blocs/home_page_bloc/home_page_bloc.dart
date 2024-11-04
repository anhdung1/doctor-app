import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_page_state.dart';
part 'home_page_event.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitialState(pageIndex: 0)) {
    on<HomePageRouteEvent>(_selectPage);
  }

  FutureOr<void> _selectPage(
      HomePageRouteEvent event, Emitter<HomePageState> emit) {
    emit(HomePageInitialState(pageIndex: event.index));
  }
}
