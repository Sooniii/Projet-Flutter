import 'package:flutter/material.dart';
import 'package:projet_flutter/db/mongo_dart.dart';

import '../db/constant.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  var passwordController = TextEditingController();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var newPasswordController = TextEditingController();
  var verifPasswordController = TextEditingController();
  var visiblePassword = false;
  var user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                    labelText: "Nom d'utilisateur",
                    icon: Icon(Icons.account_box)),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: !visiblePassword,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  labelText: "Mot de passe",
                  icon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(visiblePassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    color: Theme.of(context).primaryColorDark,
                    onPressed: () {
                      setState(() {
                        visiblePassword = !visiblePassword;
                      });
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                        MongoDatabase.getUser(usernameController.text)
                          .then((retour) {
                        setState(() {
                          user = retour;
                          if (user != null) {
                            if (passwordController.text == user["password"]) {
                              // userLogged = user;
                              // TODO : Mettre la route pour la page des news
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    buildWrongPasswordPopUp(context),
                              );
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  buildUserNotFoundPopUp(context),
                            );
                          }
                        });
                      });
                    },
                    child: const Text('Se connecter'),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            buildVerifAccountPopUp(context),
                      );
                    },
                    child: const Text('Mot de passe oublié'),
                  ),
                ],
              ),
              TextButton(
                  onPressed: () {
                    // TODO : Mettre la route pour la page inscription
                  },
                  child:
                      const Text("Vous n'avez pas de compte ? Inscrivez vous"))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildVerifAccountPopUp(BuildContext context) {
    return AlertDialog(
      title: const Text('Reinitialiser le mot de passe'),
      content: Form(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: "Nom d'utilisateur",
                icon: Icon(Icons.account_box),
              ),
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                icon: Icon(Icons.email),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Retour'),
        ),
        TextButton(
          onPressed: () {
            MongoDatabase.getUser(usernameController.text)
                .then((retour) {
              setState(() {
                user = retour;
                if (user != null) {
                  if (emailController.text == user["email"]) {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          buildChangePasswordPopUp(context),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          buildWrongEmailPopUp(context),
                    );
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        buildUserNotFoundPopUp(context),
                  );
                }
              });
            });
          },
          child: const Text('Suivant'),
        ),
      ],
    );
  }

  Widget buildChangePasswordPopUp(BuildContext context) {
    return AlertDialog(
      title: const Text('Reinitialiser le mot de passe'),
      content: Form(
        child: Column(
          children: <Widget>[
            TextFormField(
              obscureText: !visiblePassword,
              controller: newPasswordController,
              decoration: const InputDecoration(
                labelText: "Nouveau mot de passe",
                icon: Icon(Icons.lock),
              ),
            ),
            TextFormField(
              obscureText: !visiblePassword,
              controller: verifPasswordController,
              decoration: const InputDecoration(
                labelText: "Confirmer votre mot de passe",
                icon: Icon(Icons.lock),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Retour'),
        ),
        TextButton(
          onPressed: () {
            MongoDatabase.getUser(usernameController.text).then((retour){
              setState(() {
                user = retour;
                if (user != null) {
                  if (newPasswordController.text == verifPasswordController.text) {
                    MongoDatabase.updatePassword(usernameController.text, newPasswordController.text);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => buildSuccessPopUp(context),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => buildDifferentPasswordPopUp(context),
                    );
                  }
                }
              });
            });
          },
          child: const Text('Valider'),
        )
      ],
    );
  }

  Widget buildUserNotFoundPopUp(BuildContext context) {
    return AlertDialog(
        title: const Text("Utilisateur inexistant"),
        content: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok")));
  }

  Widget buildDifferentPasswordPopUp(BuildContext context) {
    return AlertDialog(
        title: const Text("Les mots de passe ne sont pas identiques"),
        content: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok")));
  }

  Widget buildWrongPasswordPopUp(BuildContext context) {
    return AlertDialog(
        title: const Text("Mot de passe incorrect"),
        content: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok")));
  }

  Widget buildWrongEmailPopUp(BuildContext context) {
    return AlertDialog(
        title: const Text("L'adresse email et le nom d'utilisateur ne correspondent pas"),
        content: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok")));
  }

  Widget buildSuccessPopUp(BuildContext context) {
    return AlertDialog(
      title: const Text("Mot de passe changé avec succès !"),
      content: TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text("Ok")),
    );
  }
}
