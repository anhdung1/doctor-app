abstract class SearchEvent {}

class SearchFetchingEvent extends SearchEvent {
  final String content;

  SearchFetchingEvent({required this.content});
}