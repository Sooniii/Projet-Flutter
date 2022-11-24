
import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';


class Riders {
  Riders({
    required this.id,
    required this.username,
    required this.password,
    required this.image,
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
  String image;
  String email;
  int role;
  String phone;
  int age;
  String ffeProfile;
  List<String> isDp;
  List<String> isOwner;

  factory Riders.fromJson(Map<String, dynamic> json) => Riders(
    id: json["_id"],
    username: json["username"],
    password: json["password"],
    image: json["image"],
    email: json["email"],
    role: json["role"],
    phone: json["phone"],
    age: json["age"],
    ffeProfile: json["ffeProfile"],
    isDp: List<String>.from(json["isDp"].map((x) => x)),
    isOwner: List<String>.from(json["isOwner"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id.toJson(),
    "username": username,
    "password": password,
    "image": image,
    "email": email,
    "role": role,
    "phone": phone,
    "age": age,
    "ffeProfile": ffeProfile,
    "isDp": List<String>.from(isDp.map((x) => x)),
    "isOwner": List<String>.from(isOwner.map((x) => x)),
  };
}

