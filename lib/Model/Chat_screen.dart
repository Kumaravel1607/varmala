// To parse this JSON data, do
//
//     final chat = chatFromJson(jsonString);

import 'dart:convert';

List<Chat> chatFromJson(String str) =>
    List<Chat>.from(json.decode(str).map((x) => Chat.fromJson(x)));

String chatToJson(List<Chat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Chat {
  Chat({
    required this.message,
    required this.date,
    required this.sendName,
    required this.receiveName,
    required this.sendPhoto,
    required this.receivePhoto,
    required this.displayName,
    required this.displayImage,
    required this.recpid,
    required this.senderid,
    required this.unRead,
  });

  String message;
  String date;
  String sendName;
  String receiveName;
  String sendPhoto;
  dynamic receivePhoto;
  String displayName;
  String displayImage;
  String senderid;
  String recpid;
  String unRead;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        message: json["message"],
        date: json["date"],
        sendName: json["send_name"],
        receiveName: json["receive_name"],
        sendPhoto: json["send_photo"],
        receivePhoto: json["receive_photo"],
        displayName: json["display_name"],
        displayImage: json["display_image"],
        recpid: json["recp_id"],
        senderid: json["sender_id"],
        unRead: json["un_read"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "date": date,
        "send_name": sendName,
        "receive_name": receiveName,
        "send_photo": sendPhoto,
        "receive_photo": receivePhoto,
        "display_name": displayName,
        "display_image": displayImage,
        "un_read": unRead,
      };
}
