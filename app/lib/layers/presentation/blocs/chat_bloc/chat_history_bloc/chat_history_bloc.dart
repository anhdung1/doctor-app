import 'dart:async';
import 'package:app/layers/domain/entities/chat_data_model.dart';
import 'package:app/layers/domain/service/chat_service.dart';
import 'package:app/layers/domain/service/result.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'chat_history_event.dart';
part 'chat_history_state.dart';

class ChatHistoryBloc extends Bloc<ChatHistoryEvent, ChatHistoryState> {
  ChatService chatService = ChatService();
  ChatHistoryBloc() : super(ChatHistoryLoadingState()) {
    on<ChatFetchingHistoryEvent>(_fectchingHistory);
    on<ChatScrollHistoryEvent>(_scroll);
  }

  FutureOr<void> _fectchingHistory(
      ChatFetchingHistoryEvent event, Emitter<ChatHistoryState> emit) async {
    try {
      chatService.onMessageReceived;
      Result chatHistory =
          await chatService.fetchChatHistory(event.receiverId, event.page);

      if (chatHistory.isSuccess) {
        if (event.page != 0 && chatHistory.data.length < 30) {
          emit(ChatHistoryCompletedState());
        }
        if (event.page != 0) {
          for (int i = chatHistory.data.length - 1; i >= 0; i--) {
            event.listMessage.insert(0, chatHistory.data[i]);
            add(ChatScrollHistoryEvent(
                listMessage: event.listMessage, quantityMessage: 1));
            await Future.delayed(const Duration(milliseconds: 10));
          }
        } else {
          event.listMessage.insertAll(0, chatHistory.data);
          emit(ChatHistorySuccessState(
              listMessage: event.listMessage,
              quantityMessage: chatHistory.data.length));
        }
      } else {
        emit(ChatHistoryFailureState(error: chatHistory.toString()));
      }
    } catch (e) {
      emit(ChatHistoryFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _scroll(
      ChatScrollHistoryEvent event, Emitter<ChatHistoryState> emit) {
    emit(ChatHistorySuccessState(
        listMessage: event.listMessage,
        quantityMessage: event.quantityMessage));
  }
}
