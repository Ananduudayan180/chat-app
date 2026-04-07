import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String chatId;
  final String lastMsgSenderId;
  final String? otherUserUid;
  final String lastMsg;
  final int unreadCount;
  final Timestamp lastMsgTime;

  ChatModel({
    required this.chatId,
    required this.lastMsg,
    required this.unreadCount,
    required this.lastMsgTime,
    required this.lastMsgSenderId,
    this.otherUserUid,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json, String otherUserUid) {
    return ChatModel(
      chatId: json['chatId'],
      otherUserUid: otherUserUid,
      lastMsgSenderId: json['lastMsgSenderId'],
      lastMsg: json['lastMsg'],
      unreadCount: json['unreadCount'],
      lastMsgTime: json['lastMsgTime'],
    );
  }

  Map<String, dynamic> toJson(List<String> participants) {
    return {
      'chatId': chatId,
      'participants': participants,
      'lastMsgSenderId': lastMsgSenderId,
      'lastMsg': lastMsg,
      'lastMsgTime': lastMsgTime,
      'unreadCount': unreadCount,
    };
  }
}
