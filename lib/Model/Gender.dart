class Gender {
  String gender;
  String id;
  String first_name,last_name,is_plan,profile_photo;

  Gender({required this.id,required this.first_name,required this.last_name,required this.is_plan,required this.profile_photo,required this.gender});
  factory Gender.fromJson(Map<String, dynamic> json) {
    return Gender(
      id:json['id'].toString(),
      first_name: json['first_name'].toString(),
      last_name: json['last_name'].toString(),
      is_plan: json['is_plan'].toString(),
      profile_photo: json['profile_photo'].toString(),
      gender:json['gender'].toString(),
    );
  }
}