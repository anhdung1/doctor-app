part of 'chat_history_bloc.dart';

abstract class ChatHistoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatFetchingHistoryEvent extends ChatHistoryEvent {
  final int receiverId;
  final List<ChatDataModel> listMessage;
  final int page;
  ChatFetchingHistoryEvent(
      {required this.receiverId,
      required this.listMessage,
      required this.page});
}

class ChatScrollHistoryEvent extends ChatHistoryEvent {
  final List<ChatDataModel> listMessage;
  final int quantityMessage;
  ChatScrollHistoryEvent(
      {required this.listMessage, required this.quantityMessage});
  @override
  List<Object?> get props => [listMessage, quantityMessage];
}
