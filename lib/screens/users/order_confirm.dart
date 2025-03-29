import 'package:flutter/material.dart';

class OrderConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No app bar per requirements.
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full-screen background image.
          Image.asset('assets/user_bg.png', fit: BoxFit.cover),
          // Centered content.
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  // Thank you text.
                  Text(
                    'Thankyou for your contribution',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Confirmation image (replace with your asset, e.g. a checkmark or similar).
                  Image.asset(
                    'assets/orderconfirmed.png',
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(height: 20),
                  // Order number.
                  Text(
                    'Order Number : 123',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Track Order button.
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1BA133),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Track Order',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
