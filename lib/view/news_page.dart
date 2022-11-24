import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:projet_flutter/class/News.dart';
import 'package:projet_flutter/db/mongo_dart.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key, required this.title});

  static const tag = "/news";
  final String title;

  @override
  State<StatefulWidget> createState() => _NewsPageState();
}

String newsType(int type) {
  late String res;
  switch (type) {
    case 0:
      res = "Cours";
      break;
    case 1:
      res = "Concours";
      break;
    case 2:
      res = "Soirée";
      break;
  }
  return res;
}

class _NewsPageState extends State<NewsPage> {
  List<News> newsList = [];
  final List<Card> _newsCards = [];

  void allCards(int index) {
    var news = newsList[index];
    _newsCards.add(Card(
      elevation: 8.0,
      child: SizedBox(
        width: 300,
        child: Column(
          children: <Widget>[
            ListTile(
              title: Center(
                  child: Text(
                newsType(news.newsType),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 21.0,
                ),
              )),
            ),
            ListTile(
              title: Center(
                  child: Text(
                news.title,
                style: const TextStyle(
                    fontWeight: FontWeight.w400, fontSize: 18.0),
              )),
            ),
            ListTile(
              title: Center(child: Text(news.content)),
            ),
            ListTile(
              title: Center(
                  child: Text(
                Jiffy(news.addedAt).fromNow(),
                style: const TextStyle(
                    fontStyle: FontStyle.italic, color: Colors.grey),
              )),
            ),
          ],
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: MongoDatabase.getNews(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                var totalData = snapshot.data.length;
                return ListView.builder(
                  itemCount: totalData,
                  itemBuilder: (BuildContext context, int index) {
                    newsList.add(snapshot.data[index]);
                    allCards(index);
                    return _newsCards[index];
                  },
                );
              }
            }
            return const Text("");
          },
        ),
      ),
    );
  }
}
