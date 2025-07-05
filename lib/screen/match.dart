import 'package:flutter/material.dart';

class MatchGIFAnimation extends StatelessWidget {
  final String user1Url;
  final String user2Url;
  final VoidCallback onDone;

  const MatchGIFAnimation({
    Key? key,
    required this.user1Url,
    required this.user2Url,
    required this.onDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.85),
      body: Stack(
        children: [
          // Centered GIF animation
          Center(
            child: Image.asset(
              'assets/match.gif', // Add your match gif to assets
              fit: BoxFit.contain,
              width: 300,
              height: 300,
            ),
          ),

          // Two avatars in the center
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCircleAvatar(user1Url),
                const SizedBox(width: 30),
                _buildCircleAvatar(user2Url),
              ],
            ),
          ),

          // Bottom text
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "It's a Match!",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent.shade100,
                ),
              ),
            ),
          ),

          // Continue button
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: onDone,
                child: const Text("Continue"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleAvatar(String imageUrl) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(imageUrl),
      backgroundColor: Colors.white,
    );
  }
}
