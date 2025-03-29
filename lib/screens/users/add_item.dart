import 'package:flutter/material.dart';
import 'package:recyclick/screens/users/device_selection.dart';

class AddItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No app bar for this page.
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full-screen background image
          Image.asset('assets/user_bg.png', fit: BoxFit.cover),
          // Content overlay with scrolling support
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo on the left with RecyClick text
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
                // Welcome text
                Center(
                  child: Text(
                    'Welcome Shubh,\nLets recycle for the present!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                // "3 Steps" text in really big size
                Center(
                  child: Text(
                    '3 Steps',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(217, 217, 217, 0.3),
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Follow the following steps :-\n'
                    '1. Click a picture.\n'
                    '2. Add details.\n'
                    '3. Hurray, you’ve successfully contributed to environment.',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Button: ADD YOUR ITEM with black outline and D9D9D9 background
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DeviceTypeSelectionPage(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Color(0xFFD9D9D9),
                      side: BorderSide(color: Colors.black),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      'ADD YOUR ITEM',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
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
