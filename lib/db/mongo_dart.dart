import 'dart:developer';

import 'package:projet_flutter/class/News.dart';

import '../class/User.dart';
import 'constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase{
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);

    var status = db.serverStatus();
    print(status);

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
  static addNews(News news) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    // news = News("L'event du moment", "Ceci est un évènement incroyable", 0, DateTime.now());

    var newsCollection = db.collection("news");
    newsCollection.insertOne({
      "title": news.title,
      "content": news.content,
      "newsType": news.newsType,
      "addedAt": news.addedAt
    });


  }
  static getNews() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);

    var newsCollection = db.collection("news");
    var test = await newsCollection?.find().toList();
    List<News> maListe=[];
    test?.forEach((element) {
      final news = News(element["title"], element["content"], element["newsType"], element["addedAt"]);
      maListe.add(news);
      });
    return maListe;
  }
}