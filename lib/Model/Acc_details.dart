// To parse this JSON data, do
//
//     final accDetails = accDetailsFromJson(jsonString);

import 'dart:convert';

AccDetails accDetailsFromJson(String str) =>
    AccDetails.fromJson(json.decode(str));

String accDetailsToJson(AccDetails data) => json.encode(data.toJson());

class AccDetails {
  AccDetails({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.isPlan,
    required this.dob,
    required this.profilePhoto,
    required this.gender,
    required this.mobile,
    required this.whatappNo,
    required this.email,
    required this.country,
    required this.state,
    required this.city,
    required this.plan,
  });

  String id;
  String firstName;
  String lastName;
  String isPlan;
  String dob;
  String profilePhoto;
  String gender;
  String mobile;
  String whatappNo;
  String email;
  String country;
  String state;
  String city;
  String plan;

  factory AccDetails.fromJson(Map<String, dynamic> json) => AccDetails(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        isPlan: json["is_plan"],
        dob: json["dob"],
        profilePhoto: json["profile_photo"],
        gender: json["gender"],
        mobile: json["mobile"],
        whatappNo: json["whatapp_no"],
        email: json["email"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        plan: json["plan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "is_plan": isPlan,
        "dob": dob,
        "profile_photo": profilePhoto,
        "gender": gender,
        "mobile": mobile,
        "whatapp_no": whatappNo,
        "email": email,
        "country": country,
        "state": state,
        "city": city,
        "plan": plan,
      };
}
