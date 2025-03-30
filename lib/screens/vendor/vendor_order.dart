import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  // Sample data for orders.
  final List<Map<String, dynamic>> orders = [
    {
      'colony': 'Green Meadows',
      'city': 'New York',
      'device': 'Refrigerator',
      'specs': 'Specs: 120V, 350L capacity, Energy Star rated.',
      'photo':
          'assets/device1.png', // Replace with actual asset or network image.
    },
    {
      'colony': 'Sunrise Villas',
      'city': 'San Francisco',
      'device': 'Washing Machine',
      'specs': 'Specs: 220V, 7kg capacity, Front load.',
      'photo':
          'assets/device2.png', // Replace with actual asset or network image.
    },
    // Add more orders as needed.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use Stack to set a background image for the entire page.
      body: Stack(
        children: [
          // Background image.
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/vendor_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Foreground content wrapped in SafeArea and SingleChildScrollView.
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Text
                  Center(
                    child: Text(
                      'Welcome Disha,\nOrders',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // List of expandable order tiles.
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ExpansionTile(
                          // Title shows a summary of the order.
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order['colony'],
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '${order['city']} - ${order['device']} for pickup',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          // Expanded content shows full device specs and photo.
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order['specs'],
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  // Display the uploaded photo.
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      order['photo'],
                                      fit: BoxFit.cover,
                                      height: 150,
                                      width: double.infinity,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
