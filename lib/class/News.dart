class News extends Comparable{
  late String title;
  late String content;
  late int newsType;
  late DateTime addedAt;

  News(this.title, this.content, this.newsType, this.addedAt);

  get date => null;

  @override
  int compareTo(other) {
    return addedAt.compareTo(other.addedAt);
  }

  // function to sort list by date
  static void sortList(List<News> list){
    list.sort((a, b) => b.compareTo(a));
  }
}