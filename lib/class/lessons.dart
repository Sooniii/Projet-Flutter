import 'package:projet_flutter/class/News.dart';

enum Place { Manege(), Carriere() }

class Lesson extends News {
  String date;
  String time;
  String place;
  String discipline;
  String duration;

  Lesson(String title, String content, int newsType, DateTime addedAt,
      this.date, this.time, this.place, this.discipline, this.duration)
      : super(title, content, newsType, addedAt);
  // Lesson(this.date, this.time) : super("Cours d'équitation", "Contenu du cours", 0, DateTime.now());
}