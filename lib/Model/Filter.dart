// To parse this JSON data, do
//
//     final filter = filterFromJson(jsonString);

import 'dart:convert';

Filter filterFromJson(String str) => Filter.fromJson(json.decode(str));

String filterToJson(Filter data) => json.encode(data.toJson());

class Filter {
  Filter({
    required this.astro,
    required this.marital,
    required this.incomeStatus,
    required this.age,
    required this.occupation,
    required this.height,
    required this.religionStatus,
    required this.community,
    required this.caste,
    required this.nationalityStatus,
  });

  List<Astro> astro;
  List<Astro> marital;
  List<Astro> incomeStatus;
  List<Age> age;
  List<Age> occupation;
  List<Astro> height;
  List<Astro> religionStatus;
  List<Age> community;
  List<Age> caste;
  List<Astro> nationalityStatus;

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        astro: List<Astro>.from(json["astro"].map((x) => Astro.fromJson(x))),
        marital:
            List<Astro>.from(json["marital"].map((x) => Astro.fromJson(x))),
        incomeStatus: List<Astro>.from(
            json["income_status"].map((x) => Astro.fromJson(x))),
        age: List<Age>.from(json["age"].map((x) => Age.fromJson(x))),
        occupation:
            List<Age>.from(json["occupation"].map((x) => Age.fromJson(x))),
        height: List<Astro>.from(json["height"].map((x) => Astro.fromJson(x))),
        religionStatus: List<Astro>.from(
            json["religion_status"].map((x) => Astro.fromJson(x))),
        community:
            List<Age>.from(json["community"].map((x) => Age.fromJson(x))),
        caste: List<Age>.from(json["caste"].map((x) => Age.fromJson(x))),
        nationalityStatus: List<Astro>.from(
            json["nationality_status"].map((x) => Astro.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "astro": List<dynamic>.from(astro.map((x) => x.toJson())),
        "marital": List<dynamic>.from(marital.map((x) => x.toJson())),
        "income_status":
            List<dynamic>.from(incomeStatus.map((x) => x.toJson())),
        "age": List<dynamic>.from(age.map((x) => x.toJson())),
        "occupation": List<dynamic>.from(occupation.map((x) => x.toJson())),
        "height": List<dynamic>.from(height.map((x) => x.toJson())),
        "religion_status":
            List<dynamic>.from(religionStatus.map((x) => x.toJson())),
        "community": List<dynamic>.from(community.map((x) => x.toJson())),
        "caste": List<dynamic>.from(caste.map((x) => x.toJson())),
        "nationality_status":
            List<dynamic>.from(nationalityStatus.map((x) => x.toJson())),
      };
}

class Age {
  Age({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Age.fromJson(Map<String, dynamic> json) => Age(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Astro {
  Astro({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Astro.fromJson(Map<String, dynamic> json) => Astro(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
