import 'package:flutter/material.dart';
import 'package:busy_bee/constants.dart';

class LeaderboardUser {
  final String name;
  final int score;
  final String profilePicUrl;
  final List<String> badges;

  LeaderboardUser(this.name, this.score, this.profilePicUrl, this.badges);
}

class ViewLeaderboardScreen extends StatelessWidget {
  final List<LeaderboardUser> users = [
    // Top 3 users
    LeaderboardUser('Lucy', 4578, 'lib/assets/images/profile1.png', [
      'lib/assets/images/cups_badge.png',
      'lib/assets/images/gigarecycle_badge.png',
      'lib/assets/imagesf/plant_badge.png',
    ]),
    LeaderboardUser('John', 4235, 'lib/assets/images/profile2.png', [
      'lib/assets/images/tree_badge.png',
      'lib/assets/images/tent_badge.png',
    ]),
    LeaderboardUser('Merry', 3967, 'lib/assets/images/profile3.png', [
      'lib/assets/images/triangle_badge.png',
      'lib/assets/images/truck_badge.png',
    ]),
    LeaderboardUser('Jose', 2999, 'lib/assets/images/profile4.png', [
      'lib/assets/images/triangle_badge.png',
      'lib/assets/images/truck_badge.png',
    ]),
    LeaderboardUser('Jane', 2020, 'lib/assets/images/profile5.png', [
      'lib/assets/images/triangle_badge.png',
      'lib/assets/images/truck_badge.png',
    ]),
    LeaderboardUser('Bella', 1890, 'lib/assets/images/profile6.png', [
      'lib/assets/images/triangle_badge.png',
      'lib/assets/images/truck_badge.png',
    ]),
    LeaderboardUser('Jeremy', 1500, 'lib/assets/images/profile7.png', [
      'lib/assets/images/triangle_badge.png',
      'lib/assets/images/truck_badge.png',
    ]),
    LeaderboardUser('Lebowsky', 1234, 'lib/assets/images/profile8.png', [
      'lib/assets/images/triangle_badge.png',
      'lib/assets/images/truck_badge.png',
    ]),
  ];
  final String currentUserId = 'David'; // Example current user

  ViewLeaderboardScreen();

  @override
  Widget build(BuildContext context) {
    final topUsers = users.take(3).toList();
    final otherUsers = users.skip(3).toList();

    return Scaffold(
      extendBodyBehindAppBar: true, // Allows the body to be drawn behind the AppBar
      appBar: AppBar(
        title: Text('Leaderboard', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: appGradient),
        child: Column(
          children: [
            SizedBox(height: kToolbarHeight + 20), // Padding below the AppBar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: topUsers.map((user) => TopLeaderboardTile(user: user)).toList(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20), // Additional padding for the top of the list
                child: ListView.builder(
                  itemCount: otherUsers.length,
                  itemBuilder: (context, index) {
                    LeaderboardUser user = otherUsers[index];
                    bool isCurrentUser = user.name == currentUserId;
                    return LeaderboardTile(
                      user: user,
                      isCurrentUser: isCurrentUser,
                      color: isCurrentUser ? sunsetOrange : offWhite,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class TopLeaderboardTile extends StatelessWidget {
  final LeaderboardUser user;

  TopLeaderboardTile({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(user.profilePicUrl),
        ),
        SizedBox(height: 8),
        Text(user.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        Text('${user.score}', style: TextStyle(color: Colors.white)),
      ],
    );
  }
}

class LeaderboardTile extends StatelessWidget {
  final LeaderboardUser user;
  final bool isCurrentUser;
  final Color? color;

  LeaderboardTile({required this.user, required this.isCurrentUser, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      elevation: isCurrentUser ? 4 : 1,
      color: color,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(user.profilePicUrl),
        ),
        title: Text(user.name, style: TextStyle(fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal)),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          children: user.badges.take(3).map((badge) => Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Image.asset(badge, width: 20),
          )).toList(),
        ),
        trailing: Text('${user.score}', style: TextStyle(color: isCurrentUser ? Colors.black : Colors.grey)),
      ),
    );
  }
}