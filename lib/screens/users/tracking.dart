import 'package:flutter/material.dart';
import 'package:recyclick/Api%20Service/api_service.dart';

class TrackingPage extends StatefulWidget {
  final String orderId;

  const TrackingPage({Key? key, required this.orderId}) : super(key: key);

  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  List<Map<String, dynamic>> trackingSteps = [
    {"title": "Order Confirmed", "completed": false},
    {"title": "Vendor Alloted", "completed": false},
    {"title": "Vendor out for picking", "completed": false},
    {"title": "Product Collected", "completed": false},
    {"title": "Product shipped to Centre", "completed": false},
    {"title": "Final check done", "completed": false},
    {"title": "Product delivered to Company", "completed": false},
    {"title": "Recycle process initiated", "completed": false},
    {"title": "Recycle process complete", "completed": false},
    {
      "title": "Thank you for your contribution! Item successfully recycled!",
      "completed": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadTrackingStatus();
  }

  Future<void> _loadTrackingStatus() async {
    try {
      // Call the API service to get the progress integer.
      int progress = await ApiService().fetchTrackingStatus(
        orderId: widget.orderId,
      );
      setState(() {
        // Mark steps with index less than the progress as completed.
        for (int i = 0; i < trackingSteps.length; i++) {
          trackingSteps[i]["completed"] = i < progress;
        }
      });
    } catch (e) {
      print("Error fetching tracking status: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full-screen background image.
          Positioned.fill(
            child: Image.asset(
              'assets/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Main content overlaid on top.
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Shubh,",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Track your contribution!",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: trackingSteps.length,
                      itemBuilder: (context, index) {
                        final step = trackingSteps[index];
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: step["completed"]
                                        ? Colors.green
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                if (index != trackingSteps.length - 1)
                                  Container(
                                    width: 2,
                                    height: 40,
                                    color: Colors.grey.shade300,
                                  ),
                              ],
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                step["title"],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: step["completed"]
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: step["completed"]
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
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
