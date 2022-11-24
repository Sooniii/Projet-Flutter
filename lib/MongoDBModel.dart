// To parse this JSON data, do
//
//     final mongoDbModel = mongoDbModelFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel mongoDbModelFromJson(String str) => MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
  MongoDbModel({
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

  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
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

class Horse {
  Horse();

  factory Horse.fromJson(Map<String, dynamic> json) => Horse(
  );

  Map<String, dynamic> toJson() => {
  };
}
