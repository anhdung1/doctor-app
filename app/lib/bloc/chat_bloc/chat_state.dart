import 'package:app/model/chat_data_model.dart';
import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatIntitalState extends ChatState {}

class ChatSuccessState extends ChatState {
  final List<ChatDataModel> listMessage;

  ChatSuccessState({required this.listMessage});
  @override
  List<Object?> get props => [listMessage];
}

class ChatLoadingState extends ChatState {}

class ChatFailureState extends ChatState {
  final String error;

  ChatFailureState({required this.error});
}

class ChatSendSuccessState extends ChatState {
  final ChatDataModel message;

  ChatSendSuccessState({required this.message});
}
