import 'package:mongo_dart/mongo_dart.dart';

class Horse{

  late String image;
  late String name;
  int? age;
  late String color;
  late String race;
  late String sexe;
  late List<String> speciality;


  Horse(this.image, this.name, this.age,
      this.color, this.race, this.sexe, this.speciality);
}