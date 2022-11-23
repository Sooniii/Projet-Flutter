import 'dart:developer';
import 'constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var collection = db.collection(COLLECTION_NAME);
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

