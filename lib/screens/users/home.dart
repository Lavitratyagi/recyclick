import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevents background shifting when keyboard appears.
      body: Stack(
        children: [
          // Full-screen background image.
          Positioned.fill(
            child: Image.asset('assets/user_bg.png', fit: BoxFit.cover),
          ),
          // Scrollable content.
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              20,
              40,
              20,
              100,
            ), // Extra bottom padding for the button.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row with logo and RecyClick text.
                Row(
                  children: [
                    Image.asset('assets/logo.png', height: 50, width: 50),
                    SizedBox(width: 10),
                    Text(
                      'RecyClick',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome Shubh,',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Track your contribution!',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 26,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    "RecyClick is a one-stop platform dedicated to making recycling effortless and accessible. We believe that small actions can create a big impact, and with just a click, you can contribute to a cleaner, greener planet. Our mission is to simplify waste management by connecting individuals and businesses with efficient recycling solutions.",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
