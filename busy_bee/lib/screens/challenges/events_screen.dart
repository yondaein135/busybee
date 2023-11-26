import 'package:flutter/material.dart';
import 'package:busy_bee/constants.dart'; // Make sure to import your constants
import 'package:table_calendar/table_calendar.dart';



class EventsScreen extends StatelessWidget {
  final List<Map<String, String>> events = [
    {"date": "2023-11-15", "name": "Park Cleanup Day"},
    {"date": "2023-11-22", "name": "Community Recycling Workshop"},
    {"date": "2023-12-03", "name": "Tree Planting Ceremony"},
  ];

  EventsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Events', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: appGradient),
        child: Column(
          children: [
            SizedBox(height: kToolbarHeight + 20),
            _buildCalendar(),
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return _buildEventCard(events[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: DateTime.now(),
      calendarFormat: CalendarFormat.month,
      // Add more properties as per your requirements
    );
  }
  Widget _buildEventCard(Map<String, String> event) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        title: Text(event['name']!, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Date: ${event['date']}'),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}