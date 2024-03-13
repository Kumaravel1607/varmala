class Puser{
  String id;
  String first_name;
  String last_name;
  String email;
  String mobile;
  String whatapp_no;
  String dob;
  String address;
  String description;
  String height;
  String weight;
  String education;
  String father_name;
  String mother_name;
  String father_occupation;
  String mother_occupation;
  String is_smoking;
  String is_drink;
  String profile_photo;
  String country,state,city,occupation,caste,community;

  Puser({required this.id,required this.first_name,required this.last_name,required this.email,required this.mobile,required this.whatapp_no,required this.dob,required this.address,required this.country,required this.state
    ,required this.city,required this.description,required this.height,required this.weight,required this.education,required this.occupation,required this.caste,required this.community,
  required this.father_name,required this.mother_name,required this.father_occupation,required this.mother_occupation,required this.is_drink,required this.is_smoking,required this.profile_photo});
  factory Puser.fromJson(Map<String, dynamic> json) {
    return Puser(
      id: json['id'].toString(),
      first_name: json['first_name'].toString(),
      last_name: json['last_name'].toString(),
      email: json['email'].toString(),
      mobile: json['mobile'].toString(),
      whatapp_no: json['whatapp_no'].toString(),
      dob: json['dob'].toString(),
      country: json['country'].toString(),
      state: json['state'].toString(),
      city: json['city'].toString(),
      address: json['address'].toString(),
      description: json['description'].toString(),
      height: json['height'].toString(),
      weight: json['weight'].toString(),
      education: json['education'].toString(),
      father_name: json['father_name'].toString(),
      mother_name: json['mother_name'].toString(),
      father_occupation: json['father_occupation'].toString(),
      mother_occupation: json['mother_occupation'].toString(),
      profile_photo: json['profile_photo'].toString(),
      is_drink: json['is_drink'].toString(),
      is_smoking: json['is_smoking'].toString(),
      occupation: json['occupation'].toString(),
      community: json['community'].toString(),
      caste: json['caste'].toString(),
    );
  }

}