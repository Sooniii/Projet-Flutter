import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Party{
  late String name;
  late String date;
  late String time;
  late String type;
  late List<ObjectId> horses;
  Icon icon;

  Party(this.name, this.date, this.time, this.icon, this.type);
}

class ImageData {
  String imageURL;
  bool isSelected;
  int id;

  ImageData(this.imageURL, this.isSelected, this.id);
}