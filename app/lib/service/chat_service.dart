import 'dart:convert';
import 'dart:developer';

import 'package:app/http_error_code.dart';
import 'package:app/model/chat_data_model.dart';
import 'package:app/service/api_service.dart';
import 'package:app/service/result.dart';
import 'package:app/service/token.dart';
import 'package:app/views/variables/variable.dart';
import 'package:http/http.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class ChatService {
  late StompClient stompClient;
  Function(ChatDataModel)? onMessageReceived;
  Future<Result> fetchChatHistory(int receiverId) async {
    List<ChatDataModel> listChat = [];
    try {
      Response response = await ApiService.getMapping(
          "chat/history?receiverId=$receiverId&senderId=${await getId() ?? -1}");
      if (response.statusCode == 200) {
        List result = jsonDecode(utf8.decode(response.bodyBytes));
        for (int i = 0; i < result.length; i++) {
          ChatDataModel chat = ChatDataModel.fromMap(
              result[i] as Map<String, dynamic>, await getId() ?? -1);
          listChat.add(chat);
        }

        return Result(data: listChat);
      } else {
        return Result(error: "error: ${getErrorMessage(response.statusCode)}");
      }
    } catch (e) {
      return Result(error: e.toString());
    }
  }

  Future<void> connectToRoom(String roomId) async {
    stompClient = StompClient(
      config: StompConfig.sockJS(
        url: 'http://$ip:8080/chat-websocket?token=${await getToken()}',
        onConnect: (StompFrame frame) => _onConnectToRoom(frame, roomId),
        onWebSocketError: (dynamic error) => log('WebSocket error: $error'),
      ),
    );

    stompClient.activate();
  }

  Future<void> _onConnectToRoom(StompFrame frame, String roomId) async {
    stompClient.subscribe(
      destination: '/topic/chat-room/$roomId',
      callback: (StompFrame frame) async {
        if (onMessageReceived != null) {
          onMessageReceived!(ChatDataModel.fromMap(
              jsonDecode(frame.body ?? "") as Map<String, dynamic>,
              await getId() ?? -1));
        }
      },
    );
    log("Connected to room: $roomId");
  }

  void sendMessageToRoom(
      String message, String senderId, String receiverId, String roomId) {
    stompClient.send(
      destination: '/app/chat.sendMessage/$roomId',
      body: '''{
        "content": "$message",
        "receiverId": "$receiverId",
        "senderId":"$senderId",
        "type": "CHAT"
      }''',
      // headers: ApiService.headers(await getToken())
    );
  }

  // Ngắt kết nối
  void disconnect() {
    stompClient.deactivate();
    log('Disconnected from WebSocket');
  }
}
