part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatConnectEvent extends ChatEvent {
  final int receiverId;
  final List<ChatDataModel> listMessage;
  ChatConnectEvent({required this.receiverId, required this.listMessage});
}

class ChatDisconnectEvent extends ChatEvent {}

class ChatSendEvent extends ChatEvent {
  final int receiverId;

  final String content;
  ChatSendEvent({required this.receiverId, required this.content});
}

class ChatReloadEvent extends ChatEvent {
  final List<ChatDataModel> listMessage;

  ChatReloadEvent({required this.listMessage});
  @override
  List<Object?> get props => [listMessage];
}
