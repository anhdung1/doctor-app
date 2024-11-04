part of 'home_page_bloc.dart';

abstract class HomePageEvent {}

class HomePageRouteEvent extends HomePageEvent {
  final int index;

  HomePageRouteEvent({required this.index});
}
