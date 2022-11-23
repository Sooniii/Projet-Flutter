import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:projet_flutter/class/User.dart';
import 'db/mongo_dart.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required String title}) : super(key: key);


  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var userNameController =  TextEditingController();
  var passwordController =  TextEditingController();
  var pictureController =  TextEditingController();
  var emailAdressController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("Créer votre compte", style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              TextField(
                controller: userNameController,
                decoration: InputDecoration(labelText: "User name"),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
              ),
              TextField(
                controller: pictureController,
                decoration: InputDecoration(labelText: "Picture"),
              ),
              TextField(
                controller: emailAdressController,
                decoration: InputDecoration(labelText: "Email adress"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () {
                    _insertData(
                      userNameController.text,
                      passwordController.text,
                      pictureController.text,
                      emailAdressController.text,
                    );
                  }, child: Text("Valider"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _insertData(String userName, String password, String picture, String emailAdress) async {
    try {
      var _id = M.ObjectId();
      var data =
      ({
        "_id": _id,
        "userName": userNameController.text,
        "password": passwordController.text,
        "picture" : passwordController.text,
        "emailAdress" : emailAdressController.text,
      });
      await MongoDatabase.insertOne(data);
    } catch (e) {
      print (e);
    }
  }
}
