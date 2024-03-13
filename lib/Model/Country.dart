class Country {
  String name;
  String id;

  Country({required this.id,required this.name});
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id:json['id'].toString(),
      name:json['name'].toString(),
    );
  }
}