import 'dart:developer';
import 'package:projet_flutter/class/News.dart';

import 'package:mongo_dart/mongo_dart.dart';

import '../class/User.dart';
import 'constant.dart';

var db, userCollection, newsCollection;

class MongoDatabase{
  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    userCollection = db.collection(COLLECTION_NAME);
    inspect(db);

    var status = db.serverStatus();
    print(status);
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
    var collection = db.collection(COLLECTION_NAME_RIDING_LESSONS);
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

  static insertOneParty(data)async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION_NAME_PARTY);
    print(collection);
    var result = await collection.insertOne(data);
  }


  static insertOneConcours(data)async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION_NAME_CONCOURS);
    print(collection);
    var result = await collection.insertOne(data);
  }
}