class States{
  String state_name;
  String id;

  States({required this.id,required this.state_name});
  factory States.fromJson(Map<String, dynamic> json) {
    return States(
      id:json['id'].toString(),
      state_name:json['state_name'].toString(),
    );
  }
}