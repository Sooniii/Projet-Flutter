import 'package:mongo_dart/mongo_dart.dart';

import '../class/Horse.dart';

class User{
  User({
  required this.id,
  required this.username,
  required this.password,
  required this.picture,
  required this.email,
  required this.role,
  required this.phone,
  required this.age,
  required this.ffeProfile,
  required this.isDp,
  required this.isOwner,
  });

  ObjectId id;
  String username;
  String password;
  String picture;
  String email;
  int role;
  String phone;
  int age;
  String ffeProfile;
  List<String> isDp;
  List<String> isOwner;

  factory User.fromJson(Map<String, dynamic> json) => User(
  id: json["_id"],
  username: json["username"],
  password: json["password"],
  picture: json["picture"],
  email: json["email"],
  role: json["role"],
  phone: json["phone"],
  age: json["age"],
  ffeProfile: json["ffeProfile"],
  isDp: List<String>.from(json["isDp"].map((x) => x)),
  isOwner: List<String>.from(json["isOwner"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
  "_id": id,
  "username": username,
  "password": password,
  "picture":  picture,
  "email": email,
  "role": role,
  "phone": phone,
  "age": age,
  "ffeProfile": ffeProfile,
    "isDp": List<String>.from(isDp.map((x) => x)),
    "isOwner": List<String>.from(isOwner.map((x) => x)),
  };
}
