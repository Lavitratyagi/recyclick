import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  // Function for "Create Account" tap action
  void _onCreateAccountTap(BuildContext context) {
    // Navigate to Create Account page or show a dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Create Account tapped!')),
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
          Image.asset(
            'assets/main_bg.png',
            fit: BoxFit.cover,
          ),
          // Overlay for the login form
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Heading
                  Text(
                    'Click. Track. Recycle',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  // Subtext
                  Text(
                    'Give old gadgets a second life instead of tossing them',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  // Container with white background and 60% opacity for text fields and buttons
                  Container(
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
                              foregroundColor: Color(0xFF1BA1332 & 0xFFFFFFFF), // Use the hex color code. Note: Fixing the hex.
                              backgroundColor: Color(0xFF1BA133), // Corrected hex color: remove extra digit
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
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
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
