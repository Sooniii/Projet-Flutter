import 'dart:developer';
import '../class/Riders.dart';
import 'package:projet_flutter/class/News.dart';

import 'package:mongo_dart/mongo_dart.dart';

import '../class/User.dart';
import '../class/Horse.dart';
import 'constant.dart';

var db, userCollection, newsCollection;

class MongoDatabase{

    static var db, riderCollection, horseCollection;
    static connect() async {
      db = await Db.create(MONGO_URL);
      await db.open();
      riderCollection = db.collection(COLLECTION_RIDER);
      horseCollection = db.collection(COLLECTION_HORSE);
    }
    static Future<void> update(Riders data) async{
      var result = await riderCollection.findOne({"_id": data.id});
      result["username"] = data.username;
      result["age"] = data.age;
      result["email"] = data.email;
      result["role"] = data.role;
      result["ffeProfile"] = data.ffeProfile;
      var response = await riderCollection.save(result);
      inspect(response);
    }
    //Fonctionne pas
    static Future<void> updateHorse(Horse data) async{
      var result = await horseCollection.findOne({"_id": data.id});
      result["owner"] = "637f52eb44a0488cf0971717";
      var response = await horseCollection.save(result);
      inspect(response);
    }

    
    
    static Future<List<Map<String,dynamic>>> getDataRider() async{
      final arrData = await riderCollection.find().toList();
      return arrData;
    }
    static Future<List<Map<String,dynamic>>> getDataHorse() async{
      final arrData = await horseCollection.find().toList();
      return arrData;
    }
    static Future<List<Map<String,dynamic>>> getQueryData() async{
      var arrData = await riderCollection
          .find(where.eq("_id", ObjectId.fromHexString("637f52eb44a0488cf0971717")))
          .toList();
    }
  static insertOne(data)async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    print("db");
    print(db);
    var collection = db.collection(COLLECTION_NAME);
    print("collection");
    print(collection);
    var result = await collection.insertOne(data);
    print("test");
    print (result);

  }

  static insertRidingLessons(data) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    print("db");
    print(db);
    var collection = db.collection("news");
    print("collection");
    print(collection);
    var result = await collection.insertOne(data);
    print("test");
    print (result);

  }

  static getNews() async {

    newsCollection = db.collection("news");
    var test = await newsCollection?.find().toList();
    List<News> maListe=[];
    test?.forEach((element) {
      final news = News(element["title"], element["content"], element["newsType"], element["addedAt"]);
      maListe.add(news);
      });
    maListe.sort((a, b) => b.addedAt.compareTo(a.addedAt));
    return maListe;
  }

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

  static getUser(String name) async {
    var user = await userCollection.findOne(where.eq("username", name));
    return user;
  }

  static updatePassword(String name, String password) async {

    await userCollection.update(where.eq('username', name), modify.set("password", password));
  }

  static insertOneParty(data) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection("party");
    print("collection");
    print(collection);
    var result = await collection.insertOne(data);
    print("test");
    print (result);
  }


  static insertOneConcours(data)async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION_NAME_CONCOURS);
    print(collection);
    var result = await collection.insertOne(data);
  }
}