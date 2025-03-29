import 'dart:async';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  // List of accomplishment texts.
  final List<String> accomplishments = [
    "Accomplishments Achieved - Keep Recycling!",
    "Appliances Recycled - Amazing Work!",
    "Eco-points Earned - Keep it Up!",
  ];

  int _currentAccIndex = 0;
  Timer? _accTimer;

  @override
  void initState() {
    super.initState();
    // Update accomplishment index every 5 seconds.
    _accTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _currentAccIndex = (_currentAccIndex + 1) % accomplishments.length;
      });
    });
  }

  @override
  void dispose() {
    _accTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Ensure background extends fully.
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full-screen background image.
          Image.asset(
            'assets/user_bg.png',
            fit: BoxFit.cover,
          ),
          // Main content overlay.
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              20,
              40,
              20,
              MediaQuery.of(context).padding.bottom + 20,
            ),
            child: Column(
              children: [
                SizedBox(height: 40),
                // Greeting texts.
                Text(
                  'Hi Shubh,',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Welcome to RecyClick',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 26,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Contributions to the nature',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 30),
                // Eco-points box restructured as a row.
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '2309',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Points Earned',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Eco-points for your sustainable efforts',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Appliances Recycled box restructured as a row.
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '27',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Appliances Recycled',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Number of units successfully submitted to e-waste centers',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // If you wish to include an icon, you can add it here.
                      // Icon(Icons.recycling, size: 40, color: Colors.black),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                // Accomplishments header.
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Accomplishments',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Animated sliding accomplishments box with only text.
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(1, 0),
                        end: Offset(0, 0),
                      ).animate(animation),
                      child: child,
                    );
                  },
                  child: Container(
                    key: ValueKey<int>(_currentAccIndex),
                    width: double.infinity,
                    height: 80, // Fixed height for consistency.
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFFCAE6A7), // Background color CAE6A7.
                      borderRadius: BorderRadius.circular(8), // Rounded corners.
                    ),
                    child: Center(
                      child: Text(
                        accomplishments[_currentAccIndex],
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
