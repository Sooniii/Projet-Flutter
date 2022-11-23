import 'package:mongo_dart/mongo_dart.dart';

class User{

  late String username;
  late String password;
  late String image;
  late String email;
  late int role;
  late List<ObjectId> horses;
  String? phone;
  int? age;
  String? ffeProfile;

  User(this.username, this.password, this.image, this.email, this.role,
      this.horses, this.phone, this.age, this.ffeProfile);
}

