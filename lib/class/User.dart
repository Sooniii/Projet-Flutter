import 'package:mongo_dart/mongo_dart.dart';

import '../class/Horse.dart';

class User{
  User({
  required this.id,
  required this.username,
  required this.password,
  required this.image,
  required this.email,
  required this.role,
  required this.horses,
  required this.phone,
  required this.age,
  required this.ffeProfile,
  });

  ObjectId id;
  String username;
  String password;
  String image;
  String email;
  int role;
  List<Horse> horses;
  String phone;
  int age;
  String ffeProfile;

  factory User.fromJson(Map<String, dynamic> json) => User(
  id: json["_id"],
  username: json["username"],
  password: json["password"],
  image: json["image"],
  email: json["email"],
  role: json["role"],
  horses: List<Horse>.from(json["horses"].map((x) => Horse.fromJson(x))),
  phone: json["phone"],
  age: json["age"],
  ffeProfile: json["ffeProfile"],
  );

  Map<String, dynamic> toJson() => {
  "_id": id,
  "username": username,
  "password": password,
  "image": image,
  "email": email,
  "role": role,
  "horses": List<dynamic>.from(horses.map((x) => x.toJson())),
  "phone": phone,
  "age": age,
  "ffeProfile": ffeProfile,
  };
}
