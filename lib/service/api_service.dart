import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../model/ArticleModel.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.31.117:8080';

  static Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse('$baseUrl/articles'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<Article> articles = jsonResponse.map((article) => Article.fromJson(article)).toList();

      for (var article in articles) {
        article.image = await fetchImage(article.imageId);
      }

      return articles;
    } else {
      throw Exception('Failed to load articles');
    }
  }

  static Future<String> fetchImage(String imageId) async {
    final response = await http.get(Uri.parse('$baseUrl/image/$imageId'));

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

  static Future<Article> fetchArticleById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/articles/$id'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      Article article = Article.fromJson(jsonResponse);
      article.image = await fetchImage(article.imageId);
      article.content = jsonResponse['content'] ?? '';
      return article;
    } else {
      throw Exception('Failed to load article');
    }
  }
}
