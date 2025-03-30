import 'package:flutter/material.dart';
import 'package:recyclick/screens/users/user_signup.dart';
import 'package:recyclick/screens/vendor/vendor_signup.dart';

class AccountType extends StatefulWidget {
  @override
  _AccountTypeState createState() => _AccountTypeState();
}

class _AccountTypeState extends State<AccountType> {
  String _selectedAccountType = 'User';
  final List<String> accountTypes = ['User', 'Vendor', 'E-waste Center'];

  void _onProceed() {
    if (_selectedAccountType == 'User') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserSignupPage()),
      );
    } else if (_selectedAccountType == 'Vendor') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VendorSignupPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Proceed with $_selectedAccountType account')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No app bar per requirements
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full-screen background image
          Image.asset('assets/main_bg.png', fit: BoxFit.cover),
          // Overlay for the form
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
              child: Column(
                children: [
                  // Headings outside the white container
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: 'Create. an. ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Account',
                          style: TextStyle(color: Color(0xFF1BA133)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 30),
                      children: [
                        TextSpan(
                          text: 'type. of. ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'account.',
                          style: TextStyle(color: Color(0xFF1BA133)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  // White container with 70% opacity for the radio buttons and proceed button
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        // Each radio button option wrapped in its own outlined container
                        Column(
                          children:
                              accountTypes.map((type) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: RadioListTile<String>(
                                    title: Text(type),
                                    value: type,
                                    groupValue: _selectedAccountType,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedAccountType = value!;
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                        ),
                        SizedBox(height: 20),
                        // Proceed button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _onProceed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1BA133),
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: Text(
                              'Proceed',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
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
