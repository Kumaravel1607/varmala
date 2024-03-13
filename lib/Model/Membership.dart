// To parse this JSON data, do
//
//     final membership = membershipFromJson(jsonString);

import 'dart:convert';

List<Membership> membershipFromJson(String str) =>
    List<Membership>.from(json.decode(str).map((x) => Membership.fromJson(x)));

String membershipToJson(List<Membership> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Membership {
  Membership({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.price,
  });

  String id;
  String title;
  String description;
  String duration;
  String price;

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        duration: json["duration"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "duration": duration,
        "price": price,
      };
}
