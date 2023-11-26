import 'package:flutter/material.dart';
import 'package:busy_bee/constants.dart';

class LocalNewsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> newsItems = [
    {"title": "Community Park Renovation", "summary": "The local community park is getting a makeover...", "image": "lib/assets/images/news1.png"},
    {"title": "New Cycling Paths", "summary": "New cycling paths have been opened to encourage green transportation...", "image": "lib/assets/images/news2.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Local News', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: appGradient),
        child: Column(
          children: [
            SizedBox(height: kToolbarHeight + 20),
            Expanded(
              child: ListView.builder(
                itemCount: newsItems.length,
                itemBuilder: (context, index) {
                  return NewsItemRow(newsItem: newsItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsItemRow extends StatelessWidget {
  final Map<String, dynamic> newsItem;

  NewsItemRow({required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 2,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                newsItem['image'],
                fit: BoxFit.cover,
                height: 100,
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      newsItem['title'],
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Text(newsItem['summary']),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
