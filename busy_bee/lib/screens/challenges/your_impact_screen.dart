import 'package:flutter/material.dart';
import 'package:busy_bee/constants.dart';

class YourImpactScreen extends StatelessWidget {
  // Dummy data for eco-friendly goals
  final List<Map<String, dynamic>> goals = [
    {"name": "Carbon Footprint Reduction", "progress": 0.7},
    {"name": "Waste Recycled", "progress": 0.5},
    {"name": "Water Saved", "progress": 0.8},
    // Add more goals here
  ];

  // List of badge image paths
  final List<String> badges = [
    'lib/assets/images/treelover_badge.png',
    'lib/assets/images/truck_badge.png',
    'lib/assets/images/tree_badge.png',
    'lib/assets/images/recycle_badge.png',
    // Add more badges here
  ];

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Your Impact', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: appGradient),
        child: LayoutBuilder( // Use LayoutBuilder to get the constraints of the parent
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(top: kToolbarHeight + 20, left: 16, right: 16, bottom: 16),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight, // Ensures minimum height equals screen height
                ),
                child: IntrinsicHeight( // Ensures Column takes up full height
                  child: Column(
                    mainAxisSize: MainAxisSize.max, // Column takes up all available space
                    children: [
                      ...goals.map((goal) => _buildGoalProgress(goal)).toList(),
                      SizedBox(height: 20),
                      _buildBadgesSection(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGoalProgress(Map<String, dynamic> goal) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            goal['name'],
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: goal['progress'],
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgesSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: badges.map((badgePath) => Image.asset(badgePath, width: 50)).toList(),
      ),
    );
  }
}
