import 'package:flutter/material.dart';
import 'package:projet_flutter/EditProfile.dart';
import 'HomePage.dart';
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
      home: const Editprofile(title: 'Ride me'),
    );
  }
}