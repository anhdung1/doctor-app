// import 'package:app/blocs/chat_bloc/chat/chat_bloc/chat_bloc.dart';
// import 'package:app/blocs/chat_bloc/chat_history_bloc/chat_history_bloc.dart';
// import 'package:app/model/chat_data_model.dart';

// import 'package:app/model/user_data_model.dart';
// import 'package:app/service/chat_service.dart';
// import 'package:app/views/constants/variable.dart';
// import 'package:app/views/widgets/clip_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ChatScreenDoctor extends StatelessWidget {
//   const ChatScreenDoctor({super.key, required this.receiver});
//   final UserDataModel receiver;
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => ChatHistoryBloc(),
//         ),
//         BlocProvider(
//           create: (context) => ChatBloc(),
//         )
//       ],
//       child: ChatScreenDoctorPage(receiver: receiver),
//     );
//   }
// }

// class ChatScreenDoctorPage extends StatefulWidget {
//   const ChatScreenDoctorPage({super.key, required this.receiver});
//   final UserDataModel receiver;

//   @override
//   State<ChatScreenDoctorPage> createState() => _ChatScreenDoctorPageState();
// }

// class _ChatScreenDoctorPageState extends State<ChatScreenDoctorPage> {
//   final ChatService chatService = ChatService();
//   late final ChatBloc _chatBloc;
//   late final ChatHistoryBloc _chatHistoryBloc;
//   final ScrollController _messageScrollController = ScrollController();
//   bool hasLoadedInitialMessages = false;
//   final TextEditingController _messageController = TextEditingController();
//   bool isLoadingMore = false;
//   final List<ChatDataModel> _messages = [];
//   int page = 1;
//   bool isCompletedHistory = false;
//   @override
//   void initState() {
//     super.initState();
//     _chatBloc = context.read<ChatBloc>();
//     _chatHistoryBloc = context.read<ChatHistoryBloc>();
//     _messageScrollController.addListener(_onScroll);
//     _chatHistoryBloc.add(ChatFetchingHistoryEvent(
//         receiverId: widget.receiver.id, listMessage: _messages, page: 0));
//     _chatBloc.add(ChatConnectEvent(
//         receiverId: widget.receiver.id, listMessage: _messages));
//   }

//   void _onScroll() async {
//     if (_messageScrollController.hasClients) {
//       if (_messageScrollController.position.pixels == 0.0 &&
//           isLoadingMore == false &&
//           !isCompletedHistory) {
//         isLoadingMore = true;
//         _chatHistoryBloc.add(ChatFetchingHistoryEvent(
//             receiverId: widget.receiver.id,
//             listMessage: _messages,
//             page: page));
//         page = page + 1;
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     _messageScrollController.dispose();
//     _chatBloc.add(ChatDisconnectEvent());
//     super.dispose();
//   }

//   _buildChatSuccessState(List<ChatDataModel> listMessage) {
//     return Column(
//       children: [
//         Expanded(
//           child: ScrollConfiguration(
//             behavior: ScrollConfiguration.of(context)
//                 .copyWith(dragDevices: dragDevices),
//             child: ListView.builder(
//               padding: const EdgeInsets.only(top: 20),
//               controller: _messageScrollController,
//               itemCount: listMessage.length,
//               itemBuilder: (context, index) {
//                 return listMessage[index].isSentByCurrentUser
//                     ? Padding(
//                         padding: const EdgeInsets.only(bottom: 2),
//                         child: Row(
//                           children: [
//                             const Expanded(child: SizedBox()),
//                             Container(
//                               alignment: const Alignment(0.5, -0.2),
//                               margin: const EdgeInsets.only(right: 10),
//                               height: 34,
//                               padding:
//                                   const EdgeInsets.only(left: 12, right: 12),
//                               decoration: BoxDecoration(
//                                   color: const Color.fromARGB(255, 0, 209, 192),
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: Expanded(
//                                 child: Text(
//                                   listMessage[index].content,
//                                   softWrap: true,
//                                   overflow: TextOverflow.visible,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     : Padding(
//                         padding: const EdgeInsets.only(bottom: 2),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 10, right: 10),
//                               child: SizedBox(
//                                   width: 34,
//                                   height: 34,
//                                   child: clipImage(widget.receiver.image)),
//                             ),
//                             Container(
//                               alignment: const Alignment(0.5, -0.2),
//                               padding:
//                                   const EdgeInsets.only(left: 12, right: 12),
//                               height: 34,
//                               decoration: BoxDecoration(
//                                   color: Colors.black12,
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: Text(
//                                 listMessage[index].content,
//                               ),
//                             )
//                           ],
//                         ),
//                       );
//               },
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   autofocus: true,
//                   controller: _messageController,
//                   onSubmitted: (value) {
//                     _chatBloc.add(ChatSendEvent(
//                       content: _messageController.text.trim(),
//                       receiverId: widget.receiver.id,
//                     ));
//                     _messageController.clear();
//                   },
//                   decoration: const InputDecoration(
//                     hintText: "Nhập tin nhắn...",
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.send),
//                 onPressed: () {
//                   _chatBloc.add(ChatSendEvent(
//                     content: _messageController.text.trim(),
//                     receiverId: widget.receiver.id,
//                   ));
//                   _messageController.clear();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Chat"),
//         backgroundColor: Colors.transparent,
//         surfaceTintColor: Colors.transparent,
//       ),
//       resizeToAvoidBottomInset: false,
//       body: BlocConsumer<ChatHistoryBloc, ChatHistoryState>(
//         builder: (context, stateHistory) {
//           if (stateHistory is ChatHistorySuccessState) {
//             return BlocConsumer<ChatBloc, ChatState>(
//               builder: (context, stateChat) {
//                 if (stateChat is ChatSuccessState) {
//                   return _buildChatSuccessState(stateChat.listMessage);
//                 }

//                 if (stateChat is ChatFailureState) {
//                   return Center(
//                     child: Text(stateChat.error),
//                   );
//                 }

//                 return const SizedBox();
//               },
//               listener: (BuildContext context, ChatState stateChat) {
//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   if (_messageScrollController.hasClients) {
//                     _messageScrollController.animateTo(
//                       _messageScrollController.position.maxScrollExtent,
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeOut,
//                     );
//                   }
//                 });
//               },
//             );
//           }
//           return const SizedBox();
//         },
//         listener: (context, stateHistory) {
//           if (stateHistory is ChatHistoryCompletedState) {
//             isCompletedHistory = true;
//           }
//           if (stateHistory is ChatHistorySuccessState) {
//             // WidgetsBinding.instance.addPostFrameCallback((_) {

//             //   if (_messageScrollController.hasClients) {
//             //     _messageScrollController.animateTo(
//             //       _messageScrollController.position.pixels +
//             //           20 +
//             //           36 * stateHistory.quantityMessage,
//             //       duration: const Duration(milliseconds: 1000),
//             //       curve: Curves.easeOut,
//             //     );
//             //   }
//             // });
//             isLoadingMore = false;
//             if (!hasLoadedInitialMessages) {
//               hasLoadedInitialMessages = !hasLoadedInitialMessages;
//             }
//           }
//         },
//       ),
//     );
//   }
// }
