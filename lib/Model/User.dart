class User {
  String id;
  String firstName;
  String lastName;
  String mobile;
  String whatsapp_no;
  String dob;
  String profile_photo;
  String favorite_status;
  String block_status;
  String profile_id;
  String stateName;
  String lastseen;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.mobile,
      required this.whatsapp_no,
      required this.dob,
      required this.profile_photo,
      required this.favorite_status,
      required this.block_status,
      required this.profile_id,
      required this.stateName,
      required this.lastseen});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      firstName: json['first_name'].toString(),
      lastName: json['last_name'].toString(),
      mobile: json['mobile'].toString(),
      whatsapp_no: json['whatapp_no'].toString(),
      dob: json['dob'].toString(),
      profile_photo: json['profile_photo'].toString(),
      favorite_status: json['favorite_status'].toString(),
      block_status: json['block_status'].toString(),
      profile_id: json['profile_id'].toString(),
      stateName: json['city'].toString(),
      lastseen: json['last_login'].toString(),
    );
  }
}
