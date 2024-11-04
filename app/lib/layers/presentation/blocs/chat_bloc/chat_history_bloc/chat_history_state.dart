part of 'chat_history_bloc.dart';

abstract class ChatHistoryState {}

class ChatHistorySuccessState extends ChatHistoryState {
  final List<ChatDataModel> listMessage;
  final int quantityMessage;
  ChatHistorySuccessState(
      {required this.listMessage, required this.quantityMessage});
}

class ChatHistoryFailureState extends ChatHistoryState {
  final String error;

  ChatHistoryFailureState({required this.error});
}

class ChatHistoryLoadingState extends ChatHistoryState {}

class ChatHistoryCompletedState extends ChatHistoryState {}
