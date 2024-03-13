class Message {
  String message;
  String date;
  String id;
  String sender_id;

  Message({
    required this.message,
    required this.date,
    required this.id,
    required this.sender_id,
  });
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'].toString(),
      date: json['date'].toString(),
      id: json['id'].toString(),
      sender_id: json['sender_id'].toString(),
    );
  }
}
