import 'package:flutter/material.dart';
import 'package:recyclick/screens/vendor/vendor_home.dart';
import 'package:recyclick/screens/vendor/vendor_order.dart';

class VendorNavbar extends StatefulWidget {
  @override
  _VendorNavbarState createState() => _VendorNavbarState();
}

class _VendorNavbarState extends State<VendorNavbar> {
  int _currentIndex = 0;

  // List of proper pages.
  final List<Widget> _pages = [
    VendorHomePage(),
    OrdersPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Background extends behind the nav bar.
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox), // Using an inbox icon as a placeholder for an open box cartoon.
            label: "Open Box",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

// Example proper Profile Page.
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Optionally, add your own app bar and content here.
      body: Center(
        child: Text(
          "This is the Profile Page",
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 24),
        ),
      ),
    );
  }
}
