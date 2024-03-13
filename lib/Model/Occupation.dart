class Occupation{
  String id;
  String name;
  Occupation({required this.id,required this.name});
  factory Occupation.fromJson(Map<String, dynamic> json) {
    return Occupation(
      id:json['id'].toString(),
      name:json['name'].toString(),
    );
  }
}