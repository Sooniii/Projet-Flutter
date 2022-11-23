import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});
  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  void _incrementCounter() {
    setState(() {
    });
  }

  var passwordController = TextEditingController();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var newPasswordController = TextEditingController();
  var verifPasswordController = TextEditingController();
  var visiblePassword = false;

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
                        ? Icons.visibility
                        : Icons.visibility_off),
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
                    onPressed: () {},
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
            var username = usernameController.text;
            var email = emailController.text;
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  buildChangePasswordPopUp(context),
            );
          },
          child: const Text('Suivant'),
        )
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
              controller: newPasswordController,
              decoration: const InputDecoration(
                labelText: "Nouveau mot de passe",
                icon: Icon(Icons.lock),
              ),
            ),
            TextFormField(
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
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  buildSuccessPopUp(context),
            );
          },
          child: const Text('Valider'),
        )
      ],
    );
  }

  Widget buildSuccessPopUp (BuildContext context) {
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
