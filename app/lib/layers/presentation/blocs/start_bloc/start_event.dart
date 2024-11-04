part of 'start_bloc.dart';

abstract class StartEvent {}

class StartContinueEvent extends StartEvent {
  final List<StartModel> startModel;
  final int count;
  StartContinueEvent({required this.startModel, required this.count});
}
