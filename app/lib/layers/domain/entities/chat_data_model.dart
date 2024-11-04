import 'package:app/layers/domain/service/json_serializable.dart';
import 'package:equatable/equatable.dart';

class ChatDataModel with EquatableMixin implements JsonSerializable {
  final String content;
  final String timestamp;
  final int senderId;
  final int receiverId;
  final bool isSentByCurrentUser;
  ChatDataModel(
      {required this.content,
      required this.timestamp,
      required this.senderId,
      required this.receiverId,
      required this.isSentByCurrentUser});
  factory ChatDataModel.fromMap(Map<String, dynamic> map, int currentUserId) {
    return ChatDataModel(
        content: map["content"] ?? "",
        timestamp: map["timestamp"] ?? "",
        senderId: map["senderId"] ?? -1,
        receiverId: map["receiverId"] ?? -1,
        isSentByCurrentUser: (map["senderId"] ?? -1) == currentUserId);
  }
  @override
  List<Object?> get props =>
      [content, timestamp, senderId, receiverId, isSentByCurrentUser];
}
