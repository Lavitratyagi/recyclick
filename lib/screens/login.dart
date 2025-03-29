import 'package:flutter/material.dart';
import 'package:recyclick/screens/account_type.dart';

class LoginPage extends StatelessWidget {
  // Function for "Create Account" tap action
  void _onCreateAccountTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccountType()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove any default app bar by leaving it null
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full-screen background image
          Image.asset('assets/main_bg.png', fit: BoxFit.cover),
          // Overlay for the login form
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Heading with Montserrat font, size 36, aligned to left
                  Text(
                    'Click. Track. Recycle',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 40,
                      fontWeight: FontWeight.w900, // Extra bold weight
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                  ),

                  SizedBox(height: 10),
                  // Subtext remains centered as before
                  Center(
                    child: Text(
                      'Give old gadgets a second life instead of tossing them',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 40),
                  // Container with white background and 60% opacity for text fields and buttons
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          // Aadhar Number TextField
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Aadhar Number',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),
                          // Password TextField
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 30),
                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Add login functionality here
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF1BA133),
                                foregroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          // "Not register yet? Create Account" text
                          GestureDetector(
                            onTap: () => _onCreateAccountTap(context),
                            child: RichText(
                              text: TextSpan(
                                text: 'Not register yet? ',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Create Account',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
