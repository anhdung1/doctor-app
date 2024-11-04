part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatInitialState extends ChatState {}

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
