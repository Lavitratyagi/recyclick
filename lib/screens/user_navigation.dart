import 'package:flutter/material.dart';
import 'package:recyclick/screens/add_item.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  // Set default index to 2 so that the PlusPage is the initial screen.
  int _currentIndex = 2;

  // List of pages for the bottom navigation bar.
  final List<Widget> _pages = [
    HomeScreen(),    // Home page placeholder
    RewardScreen(),  // Reward page placeholder
    AddItemPage(),      // Plus page (custom page)
    PinScreen(),     // Pin page placeholder
    AccountScreen(), // Account page placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Display the current page.
      body: _pages[_currentIndex],
      // Transparent bottom navigation bar with 5 icons.
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        // Both selected and unselected icons are black.
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        // Hide labels so only icons are shown.
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard), // giftbox-type icon for reward.
            label: 'Reward',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline), // plus icon.
            label: 'Plus',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pin_drop), // map pin drop icon.
            label: 'Pin',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), // user account icon.
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

// Dummy Home Screen placeholder.
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Home Screen"));
  }
}

// Dummy Reward Screen placeholder.
class RewardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Reward Screen"));
  }
}

// Dummy Pin Screen placeholder.
class PinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Pin Screen"));
  }
}

// Dummy Account Screen placeholder.
class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Account Screen"));
  }
}
