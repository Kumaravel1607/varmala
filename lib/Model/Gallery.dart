// To parse this JSON data, do
//
//     final gallery = galleryFromJson(jsonString);

import 'dart:convert';

List<Gallery> galleryFromJson(String str) =>
    List<Gallery>.from(json.decode(str).map((x) => Gallery.fromJson(x)));

String galleryToJson(List<Gallery> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Gallery {
  Gallery({
    required this.id,
    required this.image,
  });

  String id;
  String image;

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
