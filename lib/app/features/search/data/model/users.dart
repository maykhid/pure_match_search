import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

class Users {
  Users({required this.users});

  final List<User> users;

    factory Users.fromJson(List<dynamic> data) =>
      Users(users: List<User>.from(data.map((e) => User.fromJson(e))));
}

class User {
  User({
    required this.name,
    required this.email,
    required this.joinDate,
  });

  final String name;
  final String email;
  final DateTime joinDate;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        joinDate: DateTime.parse(json["join_date"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "join_date":
            "${joinDate.year.toString().padLeft(4, '0')}-${joinDate.month.toString().padLeft(2, '0')}-${joinDate.day.toString().padLeft(2, '0')}",
      };
}
