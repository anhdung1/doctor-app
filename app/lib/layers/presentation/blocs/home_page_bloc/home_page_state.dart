part of 'home_page_bloc.dart';

abstract class HomePageState {
  final int pageIndex;

  HomePageState({required this.pageIndex});
}

class HomePageInitialState extends HomePageState {
  HomePageInitialState({required super.pageIndex});
}
