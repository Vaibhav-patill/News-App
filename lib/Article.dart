import 'package:http/http.dart' as http;
import 'dart:convert';

// Define an Article model
class Article {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
    );
  }
}

// Service class to fetch news
class NewsService {
  static const _apiKey = '874d1aad5e19457c95e0893daae15b5d';
  static const _baseUrl = 'https://newsapi.org/v2';

  Future<List<Article>> fetchTopHeadlines({String country = 'us'}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/top-headlines?country=$country&apiKey=$_apiKey'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> articlesJson = json['articles'];
      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
