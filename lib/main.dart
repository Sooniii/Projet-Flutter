import 'package:flutter/material.dart';
import 'package:projet_flutter/class/lessons.dart';
import 'db/mongo_dart.dart';
import 'lesson.dart';

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
      home:  const RidingLesson(title: "tt",),
    );
  }
}