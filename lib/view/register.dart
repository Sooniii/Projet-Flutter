import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:projet_flutter/class/User.dart';
import '../db/mongo_dart.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required String title}) : super(key: key);

  static const tag = "/register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var pictureController = TextEditingController();
  var emailAdressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                "Créer votre compte",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              TextField(
                controller: userNameController,
                decoration: const InputDecoration(labelText: "User name"),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              TextField(
                controller: pictureController,
                decoration: const InputDecoration(labelText: "Picture"),
              ),
              TextField(
                controller: emailAdressController,
                decoration: const InputDecoration(labelText: "Email adress"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Retour")
                  ),
                  ElevatedButton(
                      onPressed: () {
                        MongoDatabase.getUser(userNameController.text)
                            .then((retour) {
                          setState(() {
                            var user = retour;
                            if (userNameController.text == "" ||
                                passwordController.text == "" ||
                                pictureController.text == "" ||
                                emailAdressController.text == "") {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    buildWrongFormPopUp(context),
                              );
                            } else if (user != null) {
                              if (userNameController.text == user["username"]) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      buildUserAlreadyExistPopUp(context),
                                );
                              }
                            } else {
                              _insertData(
                                userNameController.text,
                                passwordController.text,
                                pictureController.text,
                                emailAdressController.text,
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                  buildCreateUserSuccessPopUp(context)
                              );
                            }
                          });
                        });
                      },
                      child: const Text("Valider"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWrongFormPopUp(BuildContext context) {
    return AlertDialog(
        title: const Text("Veuillez remplir tout les champs !!"),
        content: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok")));
  }

  Widget buildUserAlreadyExistPopUp(BuildContext context) {
    return AlertDialog(
        title: const Text("Ce nom d'utilisateur est déjà pris"),
        content: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok")));
  }

  Widget buildCreateUserSuccessPopUp(BuildContext context) {
    return AlertDialog(
        title: const Text("Votre compte a bien été crée"),
        content: TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/login");
            },
            child: const Text("Ok")));
  }

  Future<void> _insertData(String userName, String password, String picture,
      String emailAdress) async {
    try {
      var _id = M.ObjectId();
      var data = ({
        "_id": _id,
        "username": userNameController.text,
        "password": passwordController.text,
        "picture": passwordController.text,
        "email": emailAdressController.text,
      });
      await MongoDatabase.insertOne(data);
    } catch (e) {
      print(e);
    }
  }
}
