import 'dart:async';
import 'dart:developer';
import 'package:app/layers/domain/entities/chat_data_model.dart';
import 'package:app/layers/domain/service/chat_service.dart';
import 'package:app/layers/domain/service/token.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'chat_state.dart';
part 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatService chatService = ChatService();
  ChatBloc() : super(ChatInitialState()) {
    on<ChatConnectEvent>(_connect);
    on<ChatSendEvent>(_sendMessage);

    on<ChatReloadEvent>(_reload);
    on<ChatDisconnectEvent>(_disconnect);
  }

  FutureOr<void> _connect(
      ChatConnectEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());
    try {
      int senderId = await getId() ?? -1;
      String roomId = event.receiverId < senderId
          ? "${event.receiverId}_$senderId"
          : "${senderId}_${event.receiverId}";
      await chatService.connectToRoom(roomId);

      chatService.onMessageReceived;
      emit(ChatSuccessState(listMessage: event.listMessage));
      try {
        chatService.onMessageReceived = (message) {
          event.listMessage.add(message);
          add(ChatReloadEvent(listMessage: event.listMessage));
        };
      } catch (e) {
        log(e.toString());
      }
    } catch (e) {
      emit(ChatFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _sendMessage(
      ChatSendEvent event, Emitter<ChatState> emit) async {
    try {
      var senderId = await getId() ?? -1;
      String roomId = event.receiverId < senderId
          ? "${event.receiverId}_$senderId"
          : "${senderId}_${event.receiverId}";
      if (event.content.isNotEmpty) {
        chatService.sendMessageToRoom(event.content, senderId.toString(),
            event.receiverId.toString(), roomId);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  FutureOr<void> _reload(ChatReloadEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());
    emit(ChatSuccessState(listMessage: event.listMessage));
  }

  FutureOr<void> _disconnect(
      ChatDisconnectEvent event, Emitter<ChatState> emit) {
    chatService.disconnect();
  }
}
