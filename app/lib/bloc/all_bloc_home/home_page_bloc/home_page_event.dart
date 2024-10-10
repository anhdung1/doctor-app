abstract class HomePageEvent {}

class HomePageRouteEvent extends HomePageEvent {
  final int index;

  HomePageRouteEvent({required this.index});
}
