import 'dart:core';

import 'package:mongo_dart/mongo_dart.dart';

class Horse{
  Horse({
      required this.id,
      required this.image,
      required this.name,
      required this.age,
      required this.color,
      required this.race,
      required this.sexe,
      required this.owner,
      required this.speciality
  });

    String image;
    String name;
    ObjectId id;
    int age;
    String color;
    String race;
    String sexe;
    String owner;
    List<String> speciality;

  factory Horse.fromJson(Map<String, dynamic> json) => Horse(
    id: json["_id"],
    image: json["image"],
    name: json["name"],
    age: json["age"],
    color: json["color"],
    race: json["race"],
    sexe: json["sexe"],
    owner: json["owner"],
    speciality: List<String>.from(json["speciality"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id.toJson(),
    "image": image,
    "name": name,
    "age": age,
    "color": color,
    "race": race,
    "sexe": sexe,
    "owner": owner,
    "speciality": List<dynamic>.from(speciality.map((x) => x)),
  };
}

