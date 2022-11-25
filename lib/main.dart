import 'package:flutter/material.dart';
import 'package:projet_flutter/view/concours.dart';
import 'package:projet_flutter/view/party.dart';
import 'package:projet_flutter/class/lessons.dart';
import 'view/login.dart';

import 'package:projet_flutter/view/news_page.dart';
import 'package:projet_flutter/view/register.dart';
import 'view/login.dart';
import 'view/register.dart';
import 'view/news_page.dart';

import 'db/mongo_dart.dart';
import 'view/lesson.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ride me',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const Concours(title: 'Ride me'),
      routes: {
        Register.tag: (context) => const Register(title: "Register"),
        Login.tag: (context) => const Login(title: "Login"),
        NewsPage.tag: (context) => const NewsPage(title: "News"),
        RidingLesson.tag: (context) => const RidingLesson(title: "Ajouter un cours"),
        Party.tag: (context) => const Party(title: "Ajouter une soirée"),
      },
    );
  }
}
