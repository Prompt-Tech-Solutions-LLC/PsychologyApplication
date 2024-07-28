import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/ArticleModel.dart';
import '../service/api_service.dart';

class ArticleDetailPage extends StatelessWidget {
  final int articleId;

  const ArticleDetailPage({required this.articleId, Key? key}) : super(key: key);

  void _shareArticle(Article article) {
    final String shareContent = '''
${article.title}

${article.content}

Информация взята из приложения Prompt Psychology.
[Link to the application]
''';
    Share.share(shareContent);
  }

  void _saveArticleId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedArticles = prefs.getStringList('saved_articles') ?? [];
    if (!savedArticles.contains(id.toString())) {
      savedArticles.add(id.toString());
      await prefs.setStringList('saved_articles', savedArticles);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            return Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 400.0,
                      floating: false,
                      pinned: true,
                      backgroundColor: Colors.lightBlue,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        titlePadding: EdgeInsets.zero,
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(flex: 3, child: Container()),
                            Flexible(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  softWrap: true,
                                  article.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(0.3, 0.3),
                                        blurRadius: 1,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Flexible(flex: 1, child: Container()),
                          ],
                        ),
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.memory(
                              base64Decode(article.image),
                              fit: BoxFit.cover,
                            ),
                            Container(
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: const Text(
                                    'ИССКУСТВО',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Row(
                                  children: const [
                                    Icon(Icons.timer, size: 16.0, color: Colors.grey),
                                    SizedBox(width: 4.0),
                                    Text('4 мин.', style: TextStyle(color: Colors.grey)),
                                    SizedBox(width: 16.0),
                                    Icon(Icons.remove_red_eye, size: 16.0, color: Colors.grey),
                                    SizedBox(width: 4.0),
                                    Text('300', style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                                const Spacer(),
                                const Text('28.07.2024', style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              utf8.decode(article.content.codeUnits),
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () => _shareArticle(article),
                                icon: const Icon(Icons.share, color: Colors.lightBlue),
                                label: const Text(
                                  'Поделиться',
                                  style: TextStyle(color: Colors.lightBlue),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  side: const BorderSide(color: Colors.lightBlue),
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const Center(child: Text('No article details available'));
          }
        },
      ),
    );
  }
}
