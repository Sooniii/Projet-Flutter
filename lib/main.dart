import 'package:flutter/material.dart';
import 'view/login.dart';

import 'package:projet_flutter/view/news_page.dart';
import 'package:projet_flutter/view/register.dart';
import 'view/login.dart';
import 'view/register.dart';
import 'view/news_page.dart';
import 'db/mongo_dart.dart';

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
      home: const Login(title: 'Ride me'),
      routes: {
        Register.tag: (context) => const Register(title: "Register"),
        Login.tag: (context) => const Login(title: "Login"),
        NewsPage.tag: (context) => const NewsPage(title: "News")
      },
    );
  }
}
