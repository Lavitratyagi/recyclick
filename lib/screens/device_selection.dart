import 'package:flutter/material.dart';
import 'package:recyclick/screens/image_upload.dart';

class DeviceTypeSelectionPage extends StatelessWidget {
  // List of product image asset paths.
  final List<String> productImages = [
    'assets/Smartphone.png',
    'assets/Laptop.png',
    'assets/Keyboard.png',
    'assets/Mouse.png',
    'assets/Charger.png',
    'assets/Phone charger.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No app bar per requirements.
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full-screen background image.
          Image.asset('assets/user_bg.png', fit: BoxFit.cover),
          // Content overlay with scrolling support.
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                // Welcome text.
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
                SizedBox(height: 30),
                // "Type of Product" header.
                Center(
                  child: Text(
                    'Type of Product',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Grid with 6 boxes (2 per row) for device/product selection.
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: productImages.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 boxes per row.
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    // Fixed height for each box.
                    mainAxisExtent: 120,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the photo upload page when tapped.
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PhotoUploadPage()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black), // Black outline.
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Opacity(
                            opacity: 0.7, // Image rendered at 70% opacity.
                            child: Image.asset(
                              productImages[index],
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
