import 'dart:convert';
import 'package:flutter/material.dart';
import '../model/ArticleModel.dart';
import '../service/api_service.dart';

class ArticleDetailPage extends StatelessWidget {
  final int articleId;

  const ArticleDetailPage({required this.articleId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Details'),
        backgroundColor: Colors.lightBlue,
      ),
      body: FutureBuilder<Article>(
        future: ApiService.fetchArticleById(articleId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.sentiment_dissatisfied, size: 100, color: Colors.blue),
                  SizedBox(height: 16),
                  Text(
                    'Технические шоколадки',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Что-то пошло не так на сервере. Пожалуйста, попробуйте позже.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            final article = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (article.image.isNotEmpty) ...[
                      Container(
                        height: 200.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            image: MemoryImage(base64Decode(article.image)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                    Text(
                      article.title,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      utf8.decode(article.content.codeUnits),
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('No article details available'));
          }
        },
      ),
    );
  }
}
