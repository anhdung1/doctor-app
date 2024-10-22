import 'dart:async';
import 'dart:developer';

import 'package:app/bloc/chat_bloc/chat_event.dart';
import 'package:app/bloc/chat_bloc/chat_state.dart';
import 'package:app/model/chat_data_model.dart';
import 'package:app/service/chat_service.dart';
import 'package:app/service/result.dart';
import 'package:app/service/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final List<ChatDataModel> listMessage = [];
  int page = 0;
  ChatService chatService = ChatService();
  ChatBloc() : super(ChatIntitalState()) {
    on<ChatConnectEvent>(_connect);
    on<ChatSendEvent>(_sendMessage);
    on<ChatGetHistoryEvent>(_getHistory);
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
      Result chatHistory =
          await chatService.fetchChatHistory(event.receiverId, 0);

      if (chatHistory.isSuccess) {
        listMessage.addAll(chatHistory.data);
        emit(ChatSuccessState(listMessage: listMessage));
      } else {
        emit(ChatFailureState(error: chatHistory.toString()));
      }
      try {
        chatService.onMessageReceived = (message) {
          listMessage.add(message);
          add(ChatReloadEvent());
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

  FutureOr<void> _getHistory(
      ChatGetHistoryEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());
    page = page + 1;
    Result chatHistory =
        await chatService.fetchChatHistory(event.receiverId, page);

    if (chatHistory.isSuccess) {
      listMessage.insertAll(0, chatHistory.data);
      emit(ChatHistorySuccessState());
      emit(ChatSuccessState(listMessage: listMessage));
    }
    print(page);
  }

  FutureOr<void> _reload(ChatReloadEvent event, Emitter<ChatState> emit) {
    emit(ChatLoadingState());
    emit(ChatSuccessState(listMessage: listMessage));
  }

  FutureOr<void> _disconnect(
      ChatDisconnectEvent event, Emitter<ChatState> emit) {
    chatService.disconnect();
  }
}
