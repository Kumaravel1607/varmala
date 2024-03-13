// To parse this JSON data, do
//
//     final transcation = transcationFromJson(jsonString);

import 'dart:convert';

List<Transcation> transcationFromJson(String str) => List<Transcation>.from(
    json.decode(str).map((x) => Transcation.fromJson(x)));

String transcationToJson(List<Transcation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transcation {
  Transcation({
    required this.id,
    required this.memberId,
    required this.planId,
    required this.amount,
    required this.paymentStatus,
    required this.paymentId,
    required this.ts,
    required this.title,
    required this.duration,
    required this.url,
  });

  String id;
  String memberId;
  String planId;
  String amount;
  String paymentStatus;
  String paymentId;
  DateTime ts;
  String title;
  String duration;
  String url;

  factory Transcation.fromJson(Map<String, dynamic> json) => Transcation(
        id: json["id"],
        memberId: json["member_id"],
        planId: json["plan_id"],
        amount: json["amount"],
        paymentStatus: json["payment_status"],
        paymentId: json["payment_id"],
        ts: DateTime.parse(json["ts"]),
        title: json["title"],
        duration: json["duration"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "member_id": memberId,
        "plan_id": planId,
        "amount": amount,
        "payment_status": paymentStatus,
        "payment_id": paymentId,
        "ts": ts.toIso8601String(),
        "title": title,
        "duration": duration,
        "url": url,
      };
}
