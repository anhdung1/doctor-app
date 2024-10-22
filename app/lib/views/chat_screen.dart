import 'package:app/bloc/chat_bloc/chat_bloc.dart';
import 'package:app/bloc/chat_bloc/chat_event.dart';
import 'package:app/bloc/chat_bloc/chat_state.dart';
import 'package:app/model/chat_data_model.dart';
import 'package:app/model/doctor_data_model.dart';
import 'package:app/service/chat_service.dart';
import 'package:app/views/variables/variable.dart';
import 'package:app/views/widgets/clip_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.receiver});
  final DoctorDataModel receiver;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChatBloc()..add(ChatConnectEvent(receiverId: receiver.id)),
      child: ChatScreenPage(receiver: receiver),
    );
  }
}

class ChatScreenPage extends StatefulWidget {
  const ChatScreenPage({super.key, required this.receiver});
  final DoctorDataModel receiver;

  @override
  State<ChatScreenPage> createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  final ChatService chatService = ChatService();
  late final ChatBloc _chatBloc;
  final ScrollController _messageScrollController = ScrollController();
  bool hasLoadedInitialMessages = false;
  final TextEditingController _messageController = TextEditingController();
  bool isLoadingMore = false;
  final List<ChatDataModel> messages = [];
  @override
  void initState() {
    super.initState();
    _chatBloc = context.read<ChatBloc>();
    _messageScrollController.addListener(_onScroll);
  }

  void _onScroll() async {
    if (_messageScrollController.hasClients) {
      if (_messageScrollController.position.pixels == 00.0 &&
          isLoadingMore == false) {
        print("loaded");
        isLoadingMore = true;
        _chatBloc.add(ChatGetHistoryEvent(receiverId: widget.receiver.id));
      }
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _messageScrollController.dispose();
    _chatBloc.add(ChatDisconnectEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatSuccessState) {
            return Column(
              children: [
                Expanded(
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(dragDevices: dragDevices),
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 20),
                      controller: _messageScrollController,
                      itemCount: state.listMessage.length,
                      itemBuilder: (context, index) {
                        return state.listMessage[index].isSentByCurrentUser
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: Row(
                                  children: [
                                    const Expanded(child: SizedBox()),
                                    Container(
                                      alignment: const Alignment(0.5, -0.2),
                                      margin: const EdgeInsets.only(right: 10),
                                      height: 34,
                                      padding: const EdgeInsets.only(
                                          left: 12, right: 12),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 0, 209, 192),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        state.listMessage[index].content,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: SizedBox(
                                          width: 34,
                                          height: 34,
                                          child:
                                              clipImage(widget.receiver.image)),
                                    ),
                                    Container(
                                      alignment: const Alignment(0.5, -0.2),
                                      padding: const EdgeInsets.only(
                                          left: 12, right: 12),
                                      height: 34,
                                      decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        state.listMessage[index].content,
                                      ),
                                    )
                                  ],
                                ),
                              );
                      },
                    ),
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
                                receiverId: widget.receiver.id,
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
        listener: (BuildContext context, ChatState state) {
          if (state is ChatSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_messageScrollController.hasClients) {
                _messageScrollController.animateTo(
                  _messageScrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
            });
          }
          if (state is ChatHistorySuccessState) {
            if (!hasLoadedInitialMessages) {
              hasLoadedInitialMessages = true;
            }
            isLoadingMore = false;
          }
        },
      ),
    );
  }
}
