import 'dart:html';
import 'package:busy_bee/screens/challenges/local_news_screen.dart';
import 'package:busy_bee/screens/challenges/tips_and_tricks_screen.dart';
import 'package:busy_bee/screens/challenges/your_impact_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:busy_bee/constants.dart';
import 'package:busy_bee/screens/challenges/browse_challenges_screen.dart';
import 'package:busy_bee/screens/challenges/view_leaderboard_screen.dart';
import 'package:busy_bee/screens/challenges/events_screen.dart';

import 'package:busy_bee/screens/beechat_screen.dart';



class CustomProgressBar extends StatelessWidget {
  final int points;
  final int maxPoints;

  const CustomProgressBar({
    Key? key,
    required this.points,
    this.maxPoints = 1000,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10), // Set the corner radius here
          child: LinearProgressIndicator(
            value: points / maxPoints,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            minHeight: 8,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            '$points / $maxPoints points',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}


class PlaceholderScreen extends StatelessWidget {
  final String screenName;

  PlaceholderScreen({required this.screenName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen Not Found'),
      ),
      body: Center(
        child: Text(
          'No screen found for: $screenName',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}


class UserProfileScreen extends StatelessWidget {
  final String userId;

  UserProfileScreen({Key? key, required this.userId}) : super(key: key);

  Future<Map<String, dynamic>> _fetchUserData() async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return userDoc.data() as Map<String, dynamic>;
  }

 

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
        }

        var userData = snapshot.data ?? {};

        return Scaffold(
          body: Container(
            decoration: BoxDecoration(gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryBackground, primaryBackgroundLight],
            )),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  _buildProfileSection(userData),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 4 / 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        _buildCard(context, 'Browse Challenges', Icons.search, Colors.green),
                        _buildCard(context, 'View Leaderboard', Icons.leaderboard, Colors.blue),
                        _buildCard(context, 'Events', Icons.event, Colors.red),
                        _buildCard(context, 'Local News', Icons.newspaper, Colors.orange),
                        _buildCard(context, 'Your Impact', Icons.eco, Colors.purple),
                        _buildCard(context, 'Tips and Tricks', Icons.lightbulb, Colors.yellow),
                      ],
                    ),
                  ),
                  _buildChatLaunchIcon(context), // Adding the chat launch icon
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  
Widget _buildProfileSection(Map<String, dynamic> userData) {
  int userPoints = userData['points'] ?? 0;
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage('lib/assets/images/profile.png'),
      ),
      const SizedBox(height: 20),
      Text(
        'Welcome, ${userData['fullName'] ?? 'Eco Warrior'}!',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      Text('Points Earned: $userPoints', style: TextStyle(color: Colors.white)),
      const SizedBox(height: 10),
      CustomProgressBar(points: userPoints), // Add this line
      const SizedBox(height: 20),
    ],
  );
}

 String _formatScreenName(String title) {
  return title.toLowerCase().replaceAll(' ', '_') + '.dart';
  }

Widget _getScreen(String screenName) {
  switch (screenName) {
    case 'browse_challenges.dart':
      return BrowseChallengesScreen();
    case 'view_leaderboard.dart':
      return ViewLeaderboardScreen();
    case 'tips_and_tricks.dart':
      return TipsAndTricksScreen();
    case 'events.dart':
      return EventsScreen();
    case 'local_news.dart':
      return LocalNewsScreen();
    case 'your_impact.dart':
      return YourImpactScreen();
    // Add more cases for each card
    default:
      return PlaceholderScreen(screenName: screenName);
  }
}

Widget _buildCard(BuildContext context, String title, IconData icon, Color color) {
  String screenName = _formatScreenName(title);

  return Card(
    color: color,
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => _getScreen(screenName)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
  }

  Widget _buildChatLaunchIcon(BuildContext context) {
    // Placeholder for chat launch icon
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => BeeChatScreen()), // Navigate to BeeChatScreen
        );
      },
        child: Image.asset(
          'lib/assets/images/bernard2.png',
          width: 60, // Adjust the size as needed
          height: 60,
        ),
      ),
    );
  }
}
