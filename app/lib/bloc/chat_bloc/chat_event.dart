abstract class ChatEvent {}

class ChatConnectEvent extends ChatEvent {
  final int receiverId;

  ChatConnectEvent({required this.receiverId});
}

class ChatSendEvent extends ChatEvent {
  final int receiverId;

  final String content;
  ChatSendEvent({required this.receiverId, required this.content});
}

class ChatReloadEvent extends ChatEvent {}

class ChatGetHistoryEvent extends ChatEvent {
  final int receiverId;

  ChatGetHistoryEvent({required this.receiverId});
}
