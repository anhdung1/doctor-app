import 'package:app/bloc/chat_bloc/chat_bloc.dart';
import 'package:app/bloc/chat_bloc/chat_event.dart';
import 'package:app/bloc/chat_bloc/chat_state.dart';
import 'package:app/model/chat_data_model.dart';
import 'package:app/service/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.receiverId});
  final int receiverId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChatBloc()..add(ChatConnectEvent(receiverId: receiverId)),
      child: ChatScreenPage(
        receiverId: receiverId,
      ),
    );
  }
}

class ChatScreenPage extends StatelessWidget {
  ChatScreenPage({super.key, required this.receiverId});
  final int receiverId;
  final ChatService chatService = ChatService();

  final TextEditingController _messageController = TextEditingController();

  final List<ChatDataModel> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat")),
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatSuccessState) {
            return Column(
              children: [
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                    itemCount: state.listMessage.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          "${state.listMessage[index].content} ",
                          textAlign:
                              state.listMessage[index].isSentByCurrentUser
                                  ? TextAlign.left
                                  : TextAlign.right,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          onSubmitted: (value) {},
                          decoration: const InputDecoration(
                            hintText: "Nhập tin nhắn...",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          context.read<ChatBloc>().add(ChatSendEvent(
                                content: _messageController.text.trim(),
                                receiverId: receiverId,
                              ));
                          _messageController.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          if (state is ChatFailureState) {
            return Center(
              child: Text(state.error),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
