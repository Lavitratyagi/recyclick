import 'package:flutter/material.dart';
import 'package:recyclick/screens/order_confirm.dart';

class ProductSpecsPage extends StatefulWidget {
  @override
  _ProductSpecsPageState createState() => _ProductSpecsPageState();
}

class _ProductSpecsPageState extends State<ProductSpecsPage> {
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
                // Centered header for the page.
                Center(
                  child: Text(
                    'Product Specifications',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Additional content goes here.
                // Example placeholder:
                Text(
                  'Enter your product details and specifications here.',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 300), // Placeholder for additional content.
              ],
            ),
          ),
          // Positioned button at the bottom of the screen.
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderConfirmationPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1BA133),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  'Confirm your order',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
