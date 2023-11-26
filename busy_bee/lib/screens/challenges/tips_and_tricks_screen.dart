import 'package:flutter/material.dart';
import 'package:busy_bee/constants.dart';

class TipsAndTricksScreen extends StatelessWidget {
  final List<Map<String, String>> tips = [
    {"image": "lib/assets/images/tip_placeholder1.png", "title": "Eco-Friendly Shopping Habits"},
    {"image": "lib/assets/images/tip_placeholder2.png", "title": "Reducing Home Energy Use"},
    {"image": "lib/assets/images/tip_placeholder3.png", "title": "Sustainable Gardening Techniques"},
    {"image": "lib/assets/images/tip_placeholder4.png", "title": "Water Conservation Strategies"},
    {"image": "lib/assets/images/tip_placeholder5.png", "title": "Recycling Best Practices"},
    {"image": "lib/assets/images/tip_placeholder6.png", "title": "Green Commuting Options"},
    {"image": "lib/assets/images/tip_placeholder7.png", "title": "Supporting Local Wildlife"},
    {"image": "lib/assets/images/tip_placeholder8.png", "title": "DIY Eco-Friendly Cleaning Products"},
  ];

  TipsAndTricksScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Tips and Tricks', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: appGradient),
        child: ListView.builder(
          itemCount: tips.length,
          itemBuilder: (context, index) {
            return TipCard(tip: tips[index]);
          },
        ),
      ),
    );
  }
}

class TipCard extends StatelessWidget {
  final Map<String, String> tip;

  TipCard({required this.tip});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      margin: EdgeInsets.all(10),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(15.0)),
                child: Image.asset(
                  tip['image']!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(15.0)),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  tip['title']!,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}