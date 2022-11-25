import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:projet_flutter/class/News.dart';

class Parties extends News{
  late String name;
  late String date;
  late String time;
  late String type;
  late List<ObjectId> horses;
  Icon icon;

  Parties(String title, String content, int newsType, DateTime addedAt, this.name, this.date, this.time, this.type, this.horses, this.icon) : super(title, content, newsType, addedAt);
}

class ImageData {
  String imageURL;
  bool isSelected;
  int id;

  ImageData(this.imageURL, this.isSelected, this.id);
}