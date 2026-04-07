import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;
  final String text;
  final Timestamp createdAt;

  MessageModel({
    required this.senderId,
    required this.text,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {'senderId': senderId, 'text': text, 'createdAt': createdAt};
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'],
      text: json['text'],
      createdAt: json['createdAt'],
    );
  }
}
