// To parse this JSON data, do
//
//     final tab1Details = tab1DetailsFromJson(jsonString);

import 'dart:convert';

Tab1Details tab1DetailsFromJson(String str) =>
    Tab1Details.fromJson(json.decode(str));

String tab1DetailsToJson(Tab1Details data) => json.encode(data.toJson());

class Tab1Details {
  Tab1Details({
    required this.maritalStatus,
    required this.astroStatus,
    required this.colourStatus,
    required this.birthCity,
    required this.birthState,
    required this.height,
    required this.weight,
    required this.disability,
    required this.birthTime,
    required this.birthHr,
    required this.description,
    required this.id,
  });
  String id;
  String maritalStatus;
  String astroStatus;
  String colourStatus;
  String birthCity;
  String birthState;
  String height;
  String weight;
  String disability;
  String birthTime;
  String birthHr;
  String description;

  factory Tab1Details.fromJson(Map<String, dynamic> json) => Tab1Details(
        maritalStatus: json["marital_status"],
        astroStatus: json["astro_status"],
        colourStatus: json["colour_status"],
        birthCity: json["birth_city"],
        birthState: json["birth_state"],
        height: json["height"],
        weight: json["weight"],
        disability: json["disability"],
        birthTime: json["birth_time"],
        birthHr: json["birth_hr"],
        description: json["description"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "marital_status": maritalStatus,
        "astro_status": astroStatus,
        "colour_status": colourStatus,
        "birth_city": birthCity,
        "birth_state": birthState,
        "height": height,
        "weight": weight,
        "disability": disability,
        "birth_time": birthTime,
        "birth_hr": birthHr,
        "description": description,
        "id": id
      };
}
