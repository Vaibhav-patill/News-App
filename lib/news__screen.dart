import 'package:flutter/material.dart';
import 'Article.dart';
import 'articledetail.dart';
import 'category.dart';
//import 'NewsService.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<Article>> futureArticles;
  String category = 'general';
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    futureArticles = NewsService().fetchTopHeadlines(category: category);
  }

  void updateCategory(String newCategory) {
    setState(() {
      category = newCategory;
      futureArticles = NewsService().fetchTopHeadlines(category: category);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Update category based on selected index
      switch (index) {
        case 0:
          updateCategory('general');
          break;
        case 1:
          updateCategory('business');
          break;
        case 2:
          updateCategory('sports');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Headlines'),
      ),
      body: Column(
        children: [
          CategorySelector(onCategorySelected: updateCategory),
          Expanded(
            child: FutureBuilder<List<Article>>(
              future: futureArticles,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No articles found'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final article = snapshot.data![index];
                      if (article.urlToImage == null ||
                          article.urlToImage.isEmpty) {
                        return SizedBox
                            .shrink(); // Skip articles without images
                      }
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        elevation: 5,
                        child: ListTile(
                          leading: Image.network(article.urlToImage,
                              width: 100, fit: BoxFit.cover),
                          title: Text(article.title),
                          subtitle: Text(article.description),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ArticleDetail(article: article),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'General',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports),
            label: 'Sports',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
