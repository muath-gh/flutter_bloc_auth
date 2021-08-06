class User {
  String name;
  String email;
  User({this.name, this.email});

  User.fromJson(Map<String, dynamic> json) {
    this.name = json['name'].toString();
    this.email = json['email'].toString();
  }
}
