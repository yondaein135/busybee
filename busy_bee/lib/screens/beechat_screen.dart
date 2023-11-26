import 'package:flutter/material.dart';
import 'dart:async';
import 'package:busy_bee/constants.dart';

class BeeChatScreen extends StatefulWidget {
  @override
  _BeeChatScreenState createState() => _BeeChatScreenState();
}

class _BeeChatScreenState extends State<BeeChatScreen> {
  final String _dummyPrompt = "Hello! Welcome to Bee Chat. How can I assist you today?";
  String _currentText = "";
  int _currentIndex = 0;
  Timer? _typingTimer;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _typingTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (_currentIndex < _dummyPrompt.length) {
        setState(() {
          _currentText += _dummyPrompt[_currentIndex];
          _currentIndex++;
        });
      } else {
        _typingTimer?.cancel(); // Stop the timer when finished
      }
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Bee Chat', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: appGradient),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: _buildChatBubble(_currentText),
                ),
              ),
            ),
            _buildUserInputArea(), // Add user input area
          ],
        ),
      ),
    );
  }

  Widget _buildChatBubble(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.brown[600], // Deep brown color for the chat bubble
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white), // White text
      ),
    );
  }
    Widget _buildUserInputArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: "Type your message here...",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: () {
              // Implement sending message functionality
            },
          ),
        ],
      ),
    );
  }
}
