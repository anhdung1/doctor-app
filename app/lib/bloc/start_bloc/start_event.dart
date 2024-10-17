import 'package:app/model/start_model.dart';

abstract class StartEvent {}

class StartContinueEvent extends StartEvent {
  final List<StartModel> startModel;
  final int count;
  StartContinueEvent({required this.startModel, required this.count});
}
