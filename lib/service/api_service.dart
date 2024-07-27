import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.31.117:8080';

  static Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse('$baseUrl/articles'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<Article> articles = jsonResponse.map((article) => Article.fromJson(article)).toList();

      for (var article in articles) {
        article.image = await fetchImage(article.mongoId);
      }

      return articles;
    } else {
      throw Exception('Failed to load articles');
    }
  }

  static Future<String> fetchImage(String mongoId) async {
    final response = await http.get(Uri.parse('$baseUrl/image/$mongoId'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load image');
    }
  }

  static Future<String> fetchArticleById(Long id) async {
    final response = await http.get(Uri.parse('$baseUrl/articles/$id'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load image');
    }
  }

  static Future<http.Response> addArticle(String title, String content, File imageFile) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/articles'))
      ..fields['title'] = title
      ..fields['content'] = content
      ..files.add(await http.MultipartFile.fromPath('imageFile', imageFile.path));

    var response = await request.send();
    return await http.Response.fromStream(response);
  }

}

class Article {
  final int id;
  final String title;
  final String mongoId;
  String image = '';
  String description = '';

  Article({required this.id, required this.title, required this.mongoId});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: utf8.decode(json['title'].toString().codeUnits),
      mongoId: json['mongoId'],
    );
  }
}
