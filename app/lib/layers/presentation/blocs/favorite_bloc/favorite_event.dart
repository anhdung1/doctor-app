part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteStartedEvent extends FavoriteEvent {}

class FavoriteEditEvent extends FavoriteEvent {
  final bool isFavorite;
  final int doctorId;

  FavoriteEditEvent({required this.isFavorite, required this.doctorId});
  @override
  List<Object?> get props => [isFavorite, doctorId];
}

class FavoriteUpdateEvent extends FavoriteEvent {}
