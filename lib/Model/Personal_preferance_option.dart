// To parse this JSON data, do
//
//     final optionList = optionListFromJson(jsonString);

import 'dart:convert';

OptionList optionListFromJson(String str) =>
    OptionList.fromJson(json.decode(str));

String optionListToJson(OptionList data) => json.encode(data.toJson());

class OptionList {
  OptionList({
    required this.id,
    required this.name,
  });

  var id;
  String name;

  factory OptionList.fromJson(Map<String, dynamic> json) => OptionList(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
