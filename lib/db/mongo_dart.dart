import 'dart:developer';

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
}