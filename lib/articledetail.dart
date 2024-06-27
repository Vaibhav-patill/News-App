import 'package:flutter/material.dart';
import 'Article.dart';

class ArticleDetail extends StatelessWidget {
  final Article article;

  ArticleDetail({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != '')
              Image.network(article.urlToImage),
            SizedBox(height: 10),
            Text(
              article.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              article.publishedAt,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),
            Text(
              article.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
