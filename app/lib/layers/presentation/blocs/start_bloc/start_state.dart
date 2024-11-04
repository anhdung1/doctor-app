part of 'start_bloc.dart';

abstract class StartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartPageState extends StartState {
  final List<StartModel> start;
  final int count;
  StartPageState({required this.start, required this.count});

  @override
  List<Object?> get props => [start, count];
}

class StartNextLogin extends StartState {}
