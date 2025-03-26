import 'dart:convert';

class TrolleyNews {
  final int id;
  final String date;
  final String? modified;
  final String status;
  final String? link;
  final String title;
  final String content;
  final String? excerpt;
  final String? featuredImage;

  TrolleyNews(
      {required this.id,
      required this.date,
      required this.modified,
      required this.status,
      required this.link,
      required this.title,
      required this.content,
      required this.excerpt,
      required this.featuredImage});

  factory TrolleyNews.fromJson(Map<String, dynamic> json) {
    return TrolleyNews(
        id: json['id'],
        date: json['date'],
        modified: json['modified'],
        status: json['status'],
        link: json['link'],
        title: json['title'],
        content: json['content'],
        excerpt: json['excerpt'],
        featuredImage: json['featured_image']);
  }

  List<TrolleyNews> parseTrolleyMakerNewsResponses(String jsonStr) {
    final List<dynamic> parsedList = json.decode(jsonStr);
    return parsedList.map((json) => TrolleyNews.fromJson(json)).toList();
  }
}
