import 'dart:developer';

import 'package:projet_flutter/MongoDBModel.dart';

import '../class/User.dart';
import 'constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase{

    static var db, userCollection;
    static connect() async {
      var db = await Db.create(MONGO_URL);
      await db.open();
      userCollection = db.collection(COLLECTION_NAME);
    }
    static Future<void> update(MongoDbModel data) async{
      var result = await userCollection.findOne({"_id": data.id});
      result["username"] = data.username;
      result["age"] = data.age;
      result["email"] = data.email;
      result["role"] = data.role;
      result["ffeProfile"] = data.ffeProfile;
      var response = await userCollection.save(result);
      inspect(response);
    }
    static Future<List<Map<String,dynamic>>> getData() async{
      final arrData = await userCollection.find().toList();
      return arrData;
    }
    static Future<List<Map<String,dynamic>>> getQueryData() async{
      final arrData = await userCollection
          .find()
          .toList();
      return arrData;
    }
    // User user = User("admin", "admin", "logo.png", "admin@admin.fr", 0, [], "", null, "");
    // var userCollection = db.collection(COLLECTION_NAME);
    // userCollection.insertOne({
    //   "username": user.username,
    //   "password": user.password,
    //   "image": user.image,
    //   "email": user.email,
    //   "role": user.role,
    //   "horses": user.horses,
    //   "phone": user.phone,
    //   "age": user.age,
    //   "ffeProfile": user.ffeProfile
    // });
    // print(await userCollection.find().toList());

}