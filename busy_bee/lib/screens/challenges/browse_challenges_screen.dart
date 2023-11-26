import 'package:flutter/material.dart';
import 'package:busy_bee/constants.dart';

class BrowseChallengesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> challenges = [
    {"name": "Clean a Local Park", "hours": "2"},
    {"name": "Plant a Tree", "hours": "1"},
    {"name": "Vegan Day Challenge", "hours": "24"},
    {"name": "Cycling Instead of Driving", "hours": "3"},
    {"name": "Recycling Workshop", "hours": "4"},
  ];

  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double bannerHeight = screenWidth / 2.24;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Challenges', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: appGradient),
        child: Column(
          children: [
            SizedBox(height: kToolbarHeight + 20), 
            _buildHeroBanner(context, bannerHeight),
            Expanded(
              child: ListView.builder(
                itemCount: challenges.length,
                itemBuilder: (context, index) {
                  return ChallengeRow(
                    challenge: challenges[index],
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBanner(BuildContext context, double height) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/images/challengeoftheweek.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(15)),
            child: Text(
              'Community Cleanup',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

class ChallengeRow extends StatelessWidget {
  final Map<String, dynamic> challenge;
  final int index;

  ChallengeRow({required this.challenge, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 2,
        child: Row(
          children: [
            // Image part
            Expanded(
              flex: 1,
              child: Image.asset(
                'lib/assets/images/challenge${index + 1}.png',
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      challenge['name'],
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Text('${challenge['hours']} hrs'),
                    ElevatedButton(
                      onPressed: () {

                      },
                      child: Text('Join'),
                    ),
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