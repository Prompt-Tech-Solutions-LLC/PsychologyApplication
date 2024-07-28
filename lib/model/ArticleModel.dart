import 'dart:convert';

class Article {
  final int id;
  final String title;
  final String mongoId;
  final String imageId;
  String image = '';
  String content = '';

  Article({
    required this.id,
    required this.title,
    required this.mongoId,
    required this.imageId,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] ?? 0,  // Provide a default value of 0 if id is null
      title: json['title'] != null ? utf8.decode(json['title'].toString().codeUnits) : '',
      mongoId: json['mongoId'] ?? '',
      imageId: json['imageId'] ?? '',
    );
  }
}
